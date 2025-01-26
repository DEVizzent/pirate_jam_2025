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
var run_turn : Turn
var turn_candidates : Array[Candidate]
var candidate_instances : Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.play_game_pressed.connect(start_run)
	mini_game.game_ended.connect(_on_mini_game_ended)

func start_run() -> void:
	run_turn = Turn.TUTORIAL
	tutorial()

func tutorial() -> void:
	_move_camera(CAMERA_MAIN_VIEW_POSITION, CAMERA_MAIN_VIEW_ROTATION)
	turn_candidates = game_candidates.get_candidates_by_turn(run_turn)
	await _introduce_game_candidates()
	

func start_minigame() -> void:
	await _move_camera(mini_game.get_camera_position(), mini_game.get_camera_rotation())
	mini_game.start()

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
		key = candidate_instances.find(key)
		_move_camera(candidate.position + Vector3(0, 1, -2), CAMERA_MAIN_VIEW_ROTATION)
		DialogueManager.show_dialogue_balloon(turn_candidates[key].dialogue, 'main')
		await DialogueManager.dialogue_ended
	_move_camera(CAMERA_MAIN_VIEW_POSITION, CAMERA_MAIN_VIEW_ROTATION)
	_mini_game_block()

func _mini_game_block() -> void:
	pass

func _move_camera(camera_position: Vector3, camera_rotation: Vector3) -> void:
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(camera, "position", camera_position, 2.0)
	tween.tween_property(camera, "rotation", camera_rotation, 2.0)
	await tween.finished
	return
	

func _on_mini_game_ended(excalibur_extracted : bool) -> void:
	if excalibur_extracted:
		print_debug("Excalibur extracted")
		return
	print_debug("Candidate fails")
