class_name EventConditionHasTag
extends EventCondition

@export var has_not : bool
@export var tag : KingdomEvent.Tag

func _init() -> void:
	pass

func check_condition() -> bool:
	if tag is not KingdomEvent.Tag:
		push_error('EventConditionHasTag with no tag')
	if has_not:
		return not KingdomStats.tags.has(tag)
	return KingdomStats.tags.has(tag)
