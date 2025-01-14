extends Node

signal some_signal

func emit_some_signal() -> void:
	some_signal.emit()
