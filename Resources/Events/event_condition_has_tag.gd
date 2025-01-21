class_name EventConditionHasTag
extends EventCondition

@export var tag : KingdomEvent.Tag

func _init() -> void:
	pass

func check_condition() -> bool:
	if tag is not KingdomEvent.Tag:
		push_error('EventConditionHasTag with no tag')
	return KingdomStats.tags.has(tag)
