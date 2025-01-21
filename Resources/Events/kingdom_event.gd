class_name KingdomEvent
extends Resource

enum Tag {
	EXAMPLE_1,
	EXAMPLE_2,
	EXAMPLE_3,
	EXAMPLE_4,
	EXAMPLE_5,
}

@export var internal_name : String = ''
@export var kingdom_modifier : KingdomModifier
@export var event_condition_collection : Array[EventCondition]
@export_range(0, 100) var probability : int

func invoke() -> bool:
	if (randi_range(0,100) > probability):
		print_debug(internal_name + ': Probability failed')
		return false
	for event_condition in event_condition_collection:
		if not event_condition.check_condition():
			print_debug(internal_name + ': Condition failed')
			return false
	#All conditions checked, apply the event
	kingdom_modifier.apply()
	print_debug(internal_name + ': Applied!')
	return true
	
