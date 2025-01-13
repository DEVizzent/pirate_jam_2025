extends Button

@onready var Options_panel: Panel = get_node("../OptionsPanel")

func _on_pressed():
	Options_panel.show()
	SfxAudioPlayer.play("MouseClick")
