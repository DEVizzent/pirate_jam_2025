extends Node3D
class_name GameFlow

enum Turn {TUTORIAL, FIRST, SECOND, THIRD, FOURTH, FIVETH, SIXTH, PLUS}

const CAMERA_MAIN_VIEW_POSITION : Vector3 = Vector3(0, 1, -1)
const CAMERA_MAIN_VIEW_ROTATION : Vector3 = Vector3(0, 3.14159, 0)
const CAMERA_MENU_VIEW_POSITION : Vector3 = Vector3(0, 1, 0)
const CAMERA_MENU_VIEW_ROTATION : Vector3 = Vector3(0, 0, 0)

@onready var camera : Camera3D = $Camera3D
@onready var mini_game : MiniGame = $MiniGame
@export var game_candidates : GameCandidates 
@export var general_events : Array[KingdomEvent]
var run_turn : Turn
var turn_candidates : Array[Candidate]
var candidate_instances : Array[Node3D]
var has_king : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.play_game_pressed.connect(start_run)
	mini_game.game_ended.connect(_on_mini_game_ended)

func start_run() -> void:
	MusicController.switch_to_level_song()
	run_turn = Turn.TUTORIAL
	prepare_turn_candidates()

func prepare_turn_candidates() -> void:
	_move_camera(CAMERA_MAIN_VIEW_POSITION, CAMERA_MAIN_VIEW_ROTATION)
	turn_candidates = game_candidates.get_candidates_by_turn(run_turn)
	await _introduce_game_candidates()
	

func start_minigame(candidate : Candidate) -> void:
	await _move_camera(mini_game.get_camera_position(), mini_game.get_camera_rotation())
	mini_game.start(candidate)
	await mini_game.game_ended

func _introduce_game_candidates() -> void:
	var candidate_num = 0
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel()
	for candidate in turn_candidates:
		var candidate_instance = candidate.get_character()
		add_child(candidate_instance)
		candidate_instances.append(candidate_instance)
		candidate_instance.position = CharacterPositions.spawn_position[candidate_num]
		tween.tween_property(candidate_instance, "position", CharacterPositions.presentation_position[candidate_num], randf_range(3.0, 4.0))
		candidate_num += 1
	await tween.finished
	for candidate in turn_candidates:
		DialogueManager.show_dialogue_balloon(candidate.dialogue, 'presentation')
		await DialogueManager.dialogue_ended
	_game_candidates_main()

func _game_candidates_main() -> void:
	var key : int
	for candidate in candidate_instances:
		key = candidate_instances.find(candidate)
		_move_camera(candidate.position + Vector3(0, 1, -2), CAMERA_MAIN_VIEW_ROTATION)
		DialogueManager.show_dialogue_balloon(turn_candidates[key].dialogue, 'main')
		await DialogueManager.dialogue_ended
	_move_camera(CAMERA_MAIN_VIEW_POSITION, CAMERA_MAIN_VIEW_ROTATION)
	_mini_game_block()

func _mini_game_block() -> void:
	if (run_turn == Turn.TUTORIAL):
		candidate_instances.reverse()
		turn_candidates.reverse()
	var key : int
	var previous_position : Vector3
	for candidate in candidate_instances:
		key = candidate_instances.find(candidate)
		previous_position = candidate.position
		_move_character_to_position(candidate, CharacterPositions.mini_game_position, randf_range(2., 3.))
		await get_tree().create_timer(1.0).timeout
		await start_minigame(turn_candidates[key])
		await _move_camera(CAMERA_MAIN_VIEW_POSITION + Vector3(0, 0, -1), CAMERA_MAIN_VIEW_ROTATION)
		if has_king:
			await _move_camera(CAMERA_MAIN_VIEW_POSITION + Vector3(0, 1, -1), CAMERA_MAIN_VIEW_ROTATION)
			coronation(mini_game.get_candidate())
			return
		else:
			_move_character_to_position(candidate, previous_position, randf_range(2., 3.))
	push_error('Implement no king case')

func coronation(candidate: Candidate) -> void:
	var key : int = turn_candidates.find(candidate)
	if not candidate_instances[key]:
		push_error('Candidate character not found')
	_move_character_to_position(candidate_instances[key], CharacterPositions.throne_position, 4.0)
	await get_tree().create_timer(1.0).timeout
	_move_camera(CAMERA_MAIN_VIEW_POSITION, CAMERA_MAIN_VIEW_ROTATION)
	for event in candidate.kingdom_event_collection:
		await event.invoke()
	next_round()
func execute_candidate_events(candidate_events : Array[KingdomEvent]) -> void:
	var number_of_events_to_execute : int = randi_range(3, 5)
	var number_of_executed_events : int = 0
	for candidate_event in candidate_events:
		if await candidate_event.invoke():
			number_of_executed_events += 1
		if number_of_executed_events >= number_of_events_to_execute:
			return
	general_events.shuffle()
	for general_event in general_events:
		if await general_event.invoke():
			number_of_executed_events += 1
		if number_of_executed_events >= number_of_events_to_execute:
			return
	

func next_round() -> void:
	_set_next_turn()
	var candidate_instance : Node3D = candidate_instances.pop_back()
	while candidate_instance:
		candidate_instance.queue_free()
		candidate_instance = candidate_instances.pop_back()
	prepare_turn_candidates()

func _set_next_turn() -> void:
	match run_turn:
		Turn.TUTORIAL:
			run_turn = Turn.FIRST
		Turn.FIRST:
			run_turn = Turn.SECOND
		Turn.SECOND:
			run_turn = Turn.THIRD
		Turn.THIRD:
			run_turn = Turn.FOURTH
		Turn.FOURTH:
			run_turn = Turn.FIVETH
		Turn.FIVETH:
			run_turn = Turn.SIXTH
		Turn.SIXTH:
			run_turn = Turn.PLUS
		Turn.PLUS:
			run_turn = Turn.PLUS

func _move_camera(camera_position: Vector3, camera_rotation: Vector3) -> void:
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(camera, "position", camera_position, 2.0)
	tween.tween_property(camera, "rotation", camera_rotation, 2.0)
	await tween.finished
	return

func _move_character_to_position(character : Node3D, character_position: Vector3, duration: float) -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(character, "position", character_position, duration)
	await tween.finished
	return

func _on_mini_game_ended(excalibur_extracted : bool) -> void:
	has_king = excalibur_extracted
