extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.faith_changed.connect(faith_updated)
	pass # Replace with function body.

func faith_updated(_from: int, to: int) -> void:
	pass
