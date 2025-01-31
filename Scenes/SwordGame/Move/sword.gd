extends Node3D

signal sword_mouse_over()
signal sword_mouse_exit()

var tween : Tween
var rand : RandomNumberGenerator
var candidate_strength : float = 20.0

func _ready() -> void:
	rand = RandomNumberGenerator.new()
	rand.randomize()

func _on_static_body_3d_mouse_entered():
	sword_mouse_over.emit()


func _on_static_body_3d_mouse_exited():
	sword_mouse_exit.emit()


func _on_game_game_ended(_extracted:bool) -> void:
	if not tween:
		return
	tween.stop()

func _on_game_game_started() -> void:
	apply_movement()

func apply_movement() -> void:
	if tween and tween.is_running:
		tween.kill()
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN)
	var target_rotation = Vector3(deg_to_rad(rand.randf_range(-candidate_strength, candidate_strength)), 0.0, deg_to_rad(rand.randf_range(-30.0, 30.0)))
	tween.tween_property(self,"rotation", target_rotation, rand.randf_range(0.5, 1.5))
	tween.finished.connect(apply_next_movement)
	tween.play()
	
func apply_next_movement() -> void:
	await get_tree().create_timer(randf_range(0.01, 0.3)).timeout
	apply_movement()


func _on_mini_game_game_started() -> void:
	pass # Replace with function body.
