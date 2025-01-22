class_name KingdomModifier
extends Resource

@export_range(-10, 10) var faith : int = 0
@export_range(-10, 10) var food : int = 0
@export_range(-10, 10) var force : int = 0
@export var add_tag : KingdomEvent.Tag = KingdomEvent.Tag.NO_TAG
@export var remove_tag : KingdomEvent.Tag = KingdomEvent.Tag.NO_TAG

func apply() -> void:
	KingdomStats.faith = KingdomStats.faith + faith
	KingdomStats.food = KingdomStats.food + food
	KingdomStats.force = KingdomStats.force + force
	if add_tag:
		KingdomStats.tags.append(add_tag)
	if remove_tag:
		KingdomStats.tags.erase(remove_tag)
