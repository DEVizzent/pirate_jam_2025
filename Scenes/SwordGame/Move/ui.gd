extends Control

@onready var candidate_energy_bar : TextureProgressBar = $MarginContainer/VBoxContainer/CandidateEnergy
@onready var sword_resistance_bar : TextureProgressBar = $MarginContainer/VBoxContainer/SwordResistance

func _ready() -> void:
	$"..".game_started.connect(_on_game_start)
	$"..".game_ended.connect(_on_game_end)
	$"..".update_energy_progress_bar.connect(_on_game_update_energy_progress_bar)
	$"..".update_resistance_progress_bar.connect(_on_game_update_resistance_progress_bar)

func _on_game_start() -> void:
	visible = true

func _on_game_end(_excalibur_extracted: bool) -> void:
	await get_tree().create_timer(1.0).timeout
	visible = false

func _on_game_update_energy_progress_bar(progress: float) -> void:
	candidate_energy_bar.value = progress



func _on_game_update_resistance_progress_bar(progress: float) -> void:
	sword_resistance_bar.value = progress
