extends Control

@onready var faith_value_label : Label = $VBoxContainer/HBoxContainer/Faith/Value
@onready var food_value_label : Label = $VBoxContainer/HBoxContainer/Food/Value
@onready var force_value_label : Label = $VBoxContainer/HBoxContainer/Force/Value

@export var kingdom_candidate_collection : Array[Candidate]
var candidate1 : Candidate
var candidate2 : Candidate
var candidate3 : Candidate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.faith_changed.connect(update_label.bind(faith_value_label))
	EventBus.food_changed.connect(update_label.bind(food_value_label))
	EventBus.force_changed.connect(update_label.bind(force_value_label))
	$VBoxContainer/CenterContainer/CheckButton.toggled.connect(manage_tag.bind(KingdomEvent.Tag.EXAMPLE_1))
	$VBoxContainer/CenterContainer/CheckButton2.toggled.connect(manage_tag.bind(KingdomEvent.Tag.EXAMPLE_2))
	$VBoxContainer/CenterContainer/CheckButton3.toggled.connect(manage_tag.bind(KingdomEvent.Tag.EXAMPLE_3))
	$VBoxContainer/CenterContainer/CheckButton4.toggled.connect(manage_tag.bind(KingdomEvent.Tag.EXAMPLE_4))
	$VBoxContainer/CenterContainer/CheckButton5.toggled.connect(manage_tag.bind(KingdomEvent.Tag.EXAMPLE_5))
	set_candidates()
	$VBoxContainer/HBoxContainer2/VBoxContainer/Button.pressed.connect(choose_candidate.bind(candidate1))
	$VBoxContainer/HBoxContainer2/VBoxContainer2/Button.pressed.connect(choose_candidate.bind(candidate2))
	$VBoxContainer/HBoxContainer2/VBoxContainer3/Button.pressed.connect(choose_candidate.bind(candidate3))
	

func set_candidates() -> void:
	kingdom_candidate_collection.shuffle()
	candidate1 = kingdom_candidate_collection.pop_front()
	candidate2 = kingdom_candidate_collection.pop_front()
	candidate3 = kingdom_candidate_collection.pop_front()

func update_label(_from : int, to : int, label: Label) -> void:
	label.text = str(to)

func manage_tag(toggled_on: bool, tag : KingdomEvent.Tag) -> void:
	if toggled_on:
		KingdomStats.tags.append(tag)
		return
	
	KingdomStats.tags.erase(tag)

func choose_candidate(choosen_one : Candidate) -> void:
	print_debug('Long live to king ' + choosen_one.name + '!!!!')
	DialogueManager.show_dialogue_balloon(choosen_one.presentation_dialoge)
	DialogueManager.show_dialogue_balloon(choosen_one.main_dialoge)
	for event in choosen_one.kingdom_event_collection:
		event.invoke()
