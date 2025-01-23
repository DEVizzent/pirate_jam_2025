class_name Candidate
extends Resource

@export var name : String
@export var dialogue : DialogueResource
@export var kingdom_event_collection : Array[KingdomEvent]
@export var character_scene : PackedScene

func get_character() -> Node3D:
	var character: Node3D = character_scene.instantiate()
	character.candidate_name = name
	return character
