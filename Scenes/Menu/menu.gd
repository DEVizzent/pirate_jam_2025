extends Control

signal play_game_pressed()

@onready var play_keep_scene: PackedScene = preload("res://Scenes/SwordGame/Keep/game.tscn")
@onready var options_panel : Panel = $OptionsPanel
@onready var credits_panel : Panel = $CreditsPanel

func _ready() -> void:
	MusicController.switch_to_menu_song()
	$VBoxContainer/PlayButton.pressed.connect(_on_play_button_pressed)
	$VBoxContainer/Options.pressed.connect(_on_options_pressed)
	$VBoxContainer/Credits.pressed.connect(_on_credits_pressed)
	$CreditsPanel/CloseButton.pressed.connect(_on_close_button_pressed)
	$OptionsPanel/CloseButton.pressed.connect(_on_close_button_pressed)

func _on_play_button_pressed() -> void:
	SfxAudioPlayer.play("MouseClick")
	visible = false
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	play_game_pressed.emit()

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
