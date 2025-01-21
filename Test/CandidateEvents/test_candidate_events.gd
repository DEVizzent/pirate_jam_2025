extends Control

@onready var faith_value_label : Label = $VBoxContainer/HBoxContainer/Faith/Value
@onready var food_value_label : Label = $VBoxContainer/HBoxContainer/Food/Value
@onready var force_value_label : Label = $VBoxContainer/HBoxContainer/Force/Value

@export var kingdom_event_collection : Array[KingdomEvent]
var current_event : KingdomEvent


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
	$VBoxContainer/Button.pressed.connect(execute_event)
	current_event = kingdom_event_collection.pop_front()

func update_label(_from : int, to : int, label: Label) -> void:
	label.text = str(to)
	print_debug("tag updated to " + str(to))

func manage_tag(toggled_on: bool, tag : KingdomEvent.Tag) -> void:
	if toggled_on:
		KingdomStats.tags.append(tag)
		return
	
	KingdomStats.tags.erase(tag)

func execute_event() -> void:
	if current_event.invoke():
		print_debug("Evento ejecutado")
	else:
		print_debug("Evento fallido")
	current_event = kingdom_event_collection.pop_front()
