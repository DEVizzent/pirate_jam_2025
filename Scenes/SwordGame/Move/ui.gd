extends Control

@onready var candidate_energy_bar : TextureProgressBar = $MarginContainer/VBoxContainer/CandidateEnergy
@onready var sword_resistance_bar : TextureProgressBar = $MarginContainer/VBoxContainer/SwordResistance

func _on_game_update_energy_progress_bar(progress: float) -> void:
	candidate_energy_bar.value = progress


func _on_game_update_resistance_progress_bar(progress: float) -> void:
	sword_resistance_bar.value = progress
