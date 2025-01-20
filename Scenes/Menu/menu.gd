extends Node2D

@onready var play_scene: PackedScene = preload("res://Scenes/SwordGame/Move/game.tscn")
@onready var play_keep_scene: PackedScene = preload("res://Scenes/SwordGame/Keep/game.tscn")
@onready var options_panel : Panel = $CanvasLayer/Control/OptionsPanel
@onready var credits_panel : Panel = $CanvasLayer/Control/CreditsPanel

func _ready() -> void:
	MusicController.switch_to_menu_song()

func _on_play_button_pressed() -> void:
	SfxAudioPlayer.play("MouseClick")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_tree().change_scene_to_packed(play_scene)

func _on_play_keep_button_pressed() -> void:
	SfxAudioPlayer.play("MouseClick")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_tree().change_scene_to_packed(play_keep_scene)


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
