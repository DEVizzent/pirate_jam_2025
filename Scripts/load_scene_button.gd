extends Button

@export var scene: PackedScene

func _ready() -> void:
	MusicController.switch_to_level_song()

func _on_pressed():
	get_tree().change_scene_to_packed(scene) # Replace with function body.
