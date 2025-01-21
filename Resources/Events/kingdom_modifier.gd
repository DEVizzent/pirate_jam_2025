class_name KingdomModifier
extends Resource

@export_range(-10, 10) var faith : int = 0
@export_range(-10, 10) var food : int = 0
@export_range(-10, 10) var force : int = 0

func apply() -> void:
		KingdomStats.faith = KingdomStats.faith + faith
		KingdomStats.food = KingdomStats.food + food
		KingdomStats.force = KingdomStats.force + force
