extends Control

signal king_choosen(candidate)

@onready var faith_value_label : Label = $VBoxContainer/HBoxContainer/Faith/Value
@onready var food_value_label : Label = $VBoxContainer/HBoxContainer/Food/Value
@onready var force_value_label : Label = $VBoxContainer/HBoxContainer/Force/Value

@export var kingdom_candidate_collection : Array[Candidate]
@onready var buttons : Array[Button] = [
	$MarginContainer/HBoxContainer2/VBoxContainer/Button,
	$MarginContainer/HBoxContainer2/VBoxContainer2/Button,
	$MarginContainer/HBoxContainer2/VBoxContainer3/Button
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.faith_changed.connect(update_label.bind(faith_value_label))
	EventBus.food_changed.connect(update_label.bind(food_value_label))
	EventBus.force_changed.connect(update_label.bind(force_value_label))

func connect_choose_button(candidate_number: int, candidate: Candidate) -> void:
	buttons[candidate_number].pressed.connect(choose_candidate.bind(candidate))
	

func update_label(_from : int, to : int, label: Label) -> void:
	label.text = str(to)

func choose_candidate(choosen_one : Candidate) -> void:
	king_choosen.emit(choosen_one)
