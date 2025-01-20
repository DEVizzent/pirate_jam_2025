extends Node2D

signal sword_mouse_over()
signal sword_mouse_exit()

var rand : RandomNumberGenerator

var resistance_velocity : Vector2 = Vector2.ZERO
var candidate_velocity : Vector2 = Vector2.ZERO

@onready var icon_sword : Area2D = $Player
@onready var timer : Timer = $Timer

func _ready() -> void:
	rand = RandomNumberGenerator.new()
	rand.randomize()
	sword_mouse_over.emit()
	timer.timeout.connect(apply_next_movement)

func _process(delta: float) -> void:
	icon_sword.position += (candidate_velocity + resistance_velocity) * delta
	resistance_velocity = Vector2.ZERO

func _input(input_event: InputEvent) -> void:
	if input_event is not InputEventMouseMotion:
		return
	if input_event is InputEventMouseMotion:
		resistance_velocity = input_event.velocity

func _on_static_body_entered(_area: Area2D):
	sword_mouse_over.emit()

func _on_static_body_exited(_area: Area2D):
	sword_mouse_exit.emit()

func _on_game_game_ended() -> void:
	timer.stop()
	candidate_velocity = Vector2.ZERO

func _on_game_game_started() -> void:
	apply_movement()

func apply_movement() -> void:
	timer.start(rand.randf_range(.2, 2.0))
	candidate_velocity = Vector2(rand.randi_range(-120, 120), rand.randi_range(-120, 120))

func apply_next_movement() -> void:
	await get_tree().create_timer(randf_range(0.01, 0.3)).timeout
	apply_movement()
