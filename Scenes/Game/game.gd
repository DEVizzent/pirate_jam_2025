extends Node3D
class_name GameFlow

enum Turn {TUTORIAL, FIRST, SECOND, THIRD, FOURTH, FIVETH, SIXTH}

@onready var camera : Camera3D = $Camera3D
@onready var mini_game : MiniGame = $MiniGame
var run_turn : Turn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.play_game_pressed.connect(start_run)
	mini_game.game_ended.connect(_on_mini_game_ended)

func start_run() -> void:
	run_turn = Turn.TUTORIAL
	pass
	
	

func start_minigame() -> void:
	await _move_camera(mini_game.get_camera_position(), mini_game.get_camera_rotation())
	mini_game.start()

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
