extends Node

signal play_character_animation(character: String, animation: String)
signal the_end()
signal game_over()

func animate(character: String, animation: String) -> void:
	play_character_animation.emit(character, animation)

func throw_the_end() -> void:
	the_end.emit()
	
func throw_game_over() -> void:
	game_over.emit()
