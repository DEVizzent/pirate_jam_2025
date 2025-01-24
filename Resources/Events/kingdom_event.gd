class_name KingdomEvent
extends Resource

enum Tag {
	NO_TAG, #Valor por defecto, no hace nada
	EXAMPLE_1,
	EXAMPLE_2,
	EXAMPLE_3,
	EXAMPLE_4,
	EXAMPLE_5,
	PAGANS_EXILED,
	FAE_WELCOME,
	FAMINE,
}

@export var internal_name : String = ''
@export var kingdom_modifier : KingdomModifier
@export var event_condition_collection : Array[EventCondition]
@export_range(0, 100) var probability : int = 100
@export var dialog : DialogueResource

signal event_finished()

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
	if dialog:
		DialogueManager.show_dialogue_balloon(dialog)
		await DialogueManager.dialogue_ended
	print_debug(internal_name + ': Applied!')
	return true
	
