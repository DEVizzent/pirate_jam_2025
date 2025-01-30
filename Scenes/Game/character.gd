extends Node3D
class_name Character

var candidate_name : String
@export var has_cane : bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	DialogueEventBus.play_character_animation.connect(play_animation)

func play_animation(character : String, animation: String) -> void:
	animation = 'anim/' + animation
	if character != candidate_name:
		return
	if not animation_player.has_animation(animation):
		return
	animation_player.play(animation)

func talk() -> void:
	if has_cane:
		animation_player.play("anim/talk_cane")
		return
	animation_player.play("anim/talk")
func walk() -> void:
	if has_cane:
		animation_player.play("anim/walk_cane")
		return
	animation_player.play("anim/walk")
func iddle() -> void:
	if has_cane:
		animation_player.play("anim/iddle_cane")
		return
	animation_player.play("anim/iddle")

func pensive_throne() -> void:
	animation_player.play("anim/pensive_throne")
