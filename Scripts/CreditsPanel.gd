extends Panel

func _on_close_button_pressed():
	self.hide()
	get_node("MouseClick").play()
