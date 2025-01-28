extends Node

const DEFAULT_STAT : int = 4

var faith : int:
	set(new_value):
		var previous_value : int = faith
		faith = new_value
		EventBus.emit_faith_changed(previous_value, new_value)
var food : int:
	set(new_value):
		var previous_value : int = food
		food = new_value
		EventBus.emit_food_changed(previous_value, new_value)
var force : int:
	set(new_value):
		var previous_value : int = force
		force = new_value
		EventBus.emit_force_changed(previous_value, new_value)
var tags : Array[KingdomEvent.Tag]

func _ready() -> void:
	faith = 0
	force = 0
	food = 0
	EventBus.run_started.connect(restart_values)

func restart_values() -> void:
	faith = DEFAULT_STAT
	food = DEFAULT_STAT
	force = DEFAULT_STAT
	tags.clear()
