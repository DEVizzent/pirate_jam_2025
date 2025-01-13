extends Panel

func _on_close_button_pressed():
	self.hide()
	SfxAudioPlayer.play("MouseClick")
