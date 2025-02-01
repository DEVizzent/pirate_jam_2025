extends Node3D
class_name MiniGame

signal update_energy_progress_bar(progress : float)
signal update_resistance_progress_bar(progress : float)
signal game_started()
signal game_ended(excalibur_extracted : bool)
signal sword_resistance_exhausted()
signal candidate_energy_exhausted()

var max_candidate_energy : float = 10.0
var candidate_energy : float :
	set(value):
		candidate_energy = value
		if not game_running:
			return
		update_energy_progress_bar.emit(candidate_energy/max_candidate_energy)
		if candidate_energy <= 0.0:
			candidate_energy_exhausted.emit()

var max_sword_resistance : float = 2.0
var sword_resistance : float :
	set(value):
		sword_resistance = value
		if not game_running:
			return
		update_resistance_progress_bar.emit(sword_resistance/max_sword_resistance)
		if sword_resistance <= 0.0:
			sword_resistance_exhausted.emit()
var mouse_on_sword : bool = false
var game_running : bool = false
var candidate : Candidate
var resistance_icon : Texture = preload("res://Scenes/SwordGame/icons/lock.png")
var free_icon : Texture = preload("res://Scenes/SwordGame/icons/lock_unlocked.png")
var default_mouse_icon : Texture = preload("res://Scenes/SwordGame/icons/gauntlet_default.png")

func _ready() -> void:
	candidate_energy_exhausted.connect(_on_candidate_energy_exhausted)
	sword_resistance_exhausted.connect(_on_sword_resistance_exhausted)
	$Sword.sword_mouse_over.connect(_on_sword_sword_mouse_over)
	$Sword.sword_mouse_exit.connect(_on_sword_sword_mouse_exit)
	Input.set_custom_mouse_cursor(default_mouse_icon)

func _process(delta: float) -> void:
	if not game_running:
		return
	if not mouse_on_sword:
		sword_resistance -= delta
		$Sword/particles.emitting = false
	else:
		$Sword/particles.emitting = true
	candidate_energy -= delta

func get_camera_position() -> Vector3:
	return global_position + Vector3(0.0, 1.5, 0.35)
func get_camera_rotation() -> Vector3:
	return Vector3(-1.14319, .0, .0)

func start(game_candidate : Candidate) -> void:
	candidate = game_candidate
	#MusicController.switch_to_level_song()
	max_sword_resistance = candidate.minigame_sword_resistance
	sword_resistance = candidate.minigame_sword_resistance
	max_candidate_energy = candidate.minigame_time
	candidate_energy = candidate.minigame_time
	$Sword.candidate_strength = candidate.minigame_difficulty
	await $UI.start_count()
	game_running = true
	game_started.emit()

func get_candidate() -> Candidate:
	return candidate

func _on_sword_sword_mouse_over() -> void:
	mouse_on_sword = true
	Input.set_custom_mouse_cursor(resistance_icon)

func _on_sword_sword_mouse_exit() -> void:
	mouse_on_sword = false
	Input.set_custom_mouse_cursor(free_icon)

func _on_candidate_energy_exhausted() -> void:
	game_running = false
	game_ended.emit(false)
	Input.set_custom_mouse_cursor(default_mouse_icon)

func _on_sword_resistance_exhausted() -> void:
	game_running = false
	game_ended.emit(true)
	Input.set_custom_mouse_cursor(default_mouse_icon)
