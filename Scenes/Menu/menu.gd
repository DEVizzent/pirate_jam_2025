extends Node2D

@onready var play_scene: PackedScene = preload("res://Scenes/main.tscn")
@onready var options_panel : Panel = $CanvasLayer/Control/OptionsPanel
@onready var credits_panel : Panel = $CanvasLayer/Control/CreditsPanel


func _on_play_button_pressed() -> void:
	SfxAudioPlayer.play("MouseClick")
	get_tree().change_scene_to_packed(play_scene)


func _on_options_pressed() -> void:
	options_panel.show()
	SfxAudioPlayer.play("MouseClick")


func _on_credits_pressed() -> void:
	credits_panel.show()
	SfxAudioPlayer.play("MouseClick")


func _on_close_button_pressed() -> void:
	SfxAudioPlayer.play("MouseClick")
	credits_panel.hide()
	options_panel.hide()
