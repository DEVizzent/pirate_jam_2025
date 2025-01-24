extends Node

signal play_charanter_animation(character: String, animation: String)

func animate(character: String, animation: String) -> void:
	play_charanter_animation.emit(character, animation)
