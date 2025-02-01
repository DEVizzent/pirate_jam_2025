extends Control

func _ready() -> void:
	DialogueEventBus.the_end.connect(activate_end)
	DialogueEventBus.game_over.connect(activate_game_over)
	$AnimationPlayer.animation_finished.connect(reset)

func activate_end() -> void:
	$AnimationPlayer.play('move')
	get_tree().paused = true

func activate_game_over() -> void:
	set_game_over()
	activate_end()

func set_game_over() -> void:
	$VBoxContainer/CenterContainer.hide()
	$VBoxContainer/CenterContainer2.show()

func reset(_anim_name: StringName) -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
