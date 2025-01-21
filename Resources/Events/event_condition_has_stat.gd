class_name EventConditionHasStat
extends EventCondition

enum StatName {FAITH, FOOD, FORCE}
enum Operator {EQUAL, GREATER, LOWER}

@export var stat_to_compare : StatName
@export var operator : Operator
@export_range(0,10) var value : int

 

func _init() -> void:
	if stat_to_compare is not StatName:
		push_error('No stat_to_compare set on EventConditionHasStat')
	if operator is not Operator:
		push_error('No operator set on EventConditionHasStat')
	if value is not int:
		push_error('No value set on EventConditionHasStat')

func check_condition() -> bool:
	var stat = _get_stat_to_compare()
	match operator:
		Operator.EQUAL:
			return stat == value
		Operator.GREATER:
			return stat > value
		Operator.LOWER:
			return stat < value
	push_error('Operator not matched')
	return true

func _get_stat_to_compare() -> int:
	match stat_to_compare:
		StatName.FAITH:
			return KingdomStats.faith
		StatName.FOOD:
			return KingdomStats.food
		StatName.FORCE:
			return KingdomStats.force
		_:
			push_error('Imposible to get stat_to_compare wrong type')
			return 0
		
