extends Node3D

@onready var faith_value_label : Label = $VBoxContainer/HBoxContainer/Faith/Value
@onready var food_value_label : Label = $VBoxContainer/HBoxContainer/Food/Value
@onready var force_value_label : Label = $VBoxContainer/HBoxContainer/Force/Value

@export var kingdom_candidate_collection : Array[Candidate]
var candidate1 : Candidate
var candidate2 : Candidate
var candidate3 : Candidate

var character_candidate1 : Node3D
var character_candidate2 : Node3D
var character_candidate3 : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_candidates()
	candidate_in_scene()
	
func candidate_in_scene() -> void:
	character_candidate1 = candidate1.get_character()
	add_child(character_candidate1)
	character_candidate1.position = Vector3(4, 0, -1)
	character_candidate2 = candidate2.get_character()
	add_child(character_candidate2)
	character_candidate2.position = Vector3(0, 0, -4)
	character_candidate3 = candidate3.get_character()
	add_child(character_candidate3)
	character_candidate3.position = Vector3(-4, 0, -1)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(character_candidate1, "position", Vector3(4, 0, 4), 3.0)
	tween.tween_property(character_candidate2, "position", Vector3(0, 0, 4), 3.0)
	tween.tween_property(character_candidate3, "position", Vector3(-4, 0, 4), 3.0)
	await tween.finished
	candidates_introduction()
	
	

func candidates_introduction() -> void:
	DialogueManager.show_dialogue_balloon(candidate1.dialogue, "presentation")
	await DialogueManager.dialogue_ended
	DialogueManager.show_dialogue_balloon(candidate2.dialogue, "presentation")
	await DialogueManager.dialogue_ended
	DialogueManager.show_dialogue_balloon(candidate3.dialogue, "presentation")
	await DialogueManager.dialogue_ended

func set_candidates() -> void:
	kingdom_candidate_collection.shuffle()
	candidate1 = kingdom_candidate_collection.pop_front()
	candidate2 = kingdom_candidate_collection.pop_front()
	candidate3 = kingdom_candidate_collection.pop_front()

func choose_candidate(choosen_one : Candidate) -> void:
	print_debug('Long live to king ' + choosen_one.name + '!!!!')
	DialogueManager.show_dialogue_balloon(choosen_one.dialogue, 'main')
	await DialogueManager.dialogue_ended
	for event in choosen_one.kingdom_event_collection:
		await event.invoke()
