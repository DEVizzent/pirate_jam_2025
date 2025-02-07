class_name Candidate
extends Resource
enum SocialClass {CLERGY, NOBILITY, PLEBE}

@export var name : String
@export var social_class : SocialClass
@export var candidate_conditions : Array[EventCondition]
@export var dialogue : DialogueResource
@export var kingdom_event_collection : Array[KingdomEvent]
@export_range(0, 10, .1) var minigame_sword_resistance : float = 3
@export_range(0, 20) var minigame_difficulty : int = 10
@export_range(0, 300) var minigame_time : int = 10
@export var character_scene : PackedScene = preload("res://Test/CandidateEvents/candidate_cube.tscn")

func get_character() -> Character:
	var character: Character = character_scene.instantiate()
	character.candidate_name = name
	return character
