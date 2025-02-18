extends Control

signal play_game_pressed()

@onready var options_panel : Panel = $OptionsPanel
@onready var credits_panel : Panel = $CreditsPanel

func _ready() -> void:
	MusicController.switch_to_menu_song()
	$VBoxContainer/PlayButton.pressed.connect(_on_play_button_pressed)
	$VBoxContainer/Options.pressed.connect(_on_options_pressed)
	$VBoxContainer/Credits.pressed.connect(_on_credits_pressed)
	$CreditsPanel/MarginContainer/CloseButton.pressed.connect(_on_close_button_pressed)
	$OptionsPanel/MarginContainer/CloseButton.pressed.connect(_on_close_button_pressed)

func _on_play_button_pressed() -> void:
	SfxAudioPlayer.play("MouseClick")
	MusicController.switch_to_level_song()
	var tween : Tween = create_tween()
	tween.tween_property(self, 'position', Vector2(0., -650.), 1.5)
	await tween.finished
	visible = false
	position = Vector2.ZERO
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
