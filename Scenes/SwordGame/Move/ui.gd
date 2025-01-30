extends Control

@onready var candidate_energy_bar : TextureProgressBar = $MarginContainer/VBoxContainer/CandidateEnergy
@onready var sword_resistance_bar : TextureProgressBar = $MarginContainer/VBoxContainer/SwordResistance
@onready var counter: Label = $Counter

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

func start_count() -> void:
	show()
	counter.show()
	for number in [3,2,1]:
		set_counter_to(number)
		var tween : Tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_parallel(true)
		tween.tween_property(counter, "label_settings:font_color:a", 0.1, 1.0)
		tween.tween_property(counter, "label_settings:font_size", 350, 1.0)
		await tween.finished
		tween.kill()
	counter.hide()


func set_counter_to(number : int) -> void :
	counter.text = str(number)
	counter.label_settings.font_size = 200
	counter.label_settings.font_color.a = 1.

func _on_game_update_resistance_progress_bar(progress: float) -> void:
	sword_resistance_bar.value = progress
