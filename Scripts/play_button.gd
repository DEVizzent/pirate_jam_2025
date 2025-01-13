extends Button

@onready var main_scene: PackedScene = preload("res://Scenes/main.tscn")

func _on_pressed():
	SfxAudioPlayer.play("MouseClick")
	get_tree().change_scene_to_packed(main_scene)
	
