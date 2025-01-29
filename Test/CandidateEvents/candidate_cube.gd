extends Node3D

var candidate_name : String
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueEventBus.play_character_animation.connect(play_animation)

func play_animation(character : String, animation: String) -> void:
	if character != candidate_name:
		return
	if not animation_player.has_animation(animation):
		return
	animation_player.play(animation)
