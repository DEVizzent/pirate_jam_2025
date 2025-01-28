extends Node

signal faith_changed(from : int, to : int)
signal food_changed(from : int, to : int)
signal force_changed(from : int, to : int)
signal run_started()

func emit_faith_changed(from : int, to : int) -> void:
	faith_changed.emit(from, to)
func emit_food_changed(from : int, to : int) -> void:
	food_changed.emit(from, to)
func emit_force_changed(from : int, to : int) -> void:
	force_changed.emit(from, to)
func emit_run_started() -> void:
	run_started.emit()
