extends Node

signal play_character_animation(character: String, animation: String)

func animate(character: String, animation: String) -> void:
	play_character_animation.emit(character, animation)
