class_name KingdomEvent
extends Resource

enum Tag {
	NO_TAG, #Valor por defecto, no hace nada
	PAGANS_EXILED,
	FRENCH_SPOKEN,
	FAKE_POPE,
	DRAGONSLAYER,
	HOLY_GRAIL,
	FAE_WELCOME,
	FAE_DIPLOMACY,
	WRONG_CRUSADE,
	DEER_CHILD,
	FAMINE,
	FAE_FRIENDS,
	FRANCE_DOMINANCE,
	FRANCE_REJECTED,
	CATHEDRALS,
	SAINT_ARTHUR,
	REJECTED_BY_ROME,
	ROME_LOVES_BRITAIN,
	EUROPE_FEARS_BRITAIN,
	EUROPE_MOCKS_BRITAIN,
	FAE_EXILED,
	FAMISHED,
	AKAB,
}

@export var internal_name : String = ''
@export var kingdom_modifier : KingdomModifier
@export var event_condition_collection : Array[EventCondition]
@export_range(0, 100) var probability : int = 100
@export var dialog : DialogueResource

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
	
