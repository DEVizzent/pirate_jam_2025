extends Area2D

var interactable : bool
@export var dialogues: Array[DialogueResource]
@export var dialogueStart: String = "start"
var currentDialogue : int = 0

func _ready():
	interactable = false

func _on_body_entered(body):
	if body.name == "Player":
		interactable = true

func _process(delta):
	if interactable:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_example_dialogue_balloon(dialogues[currentDialogue], dialogueStart)

func _on_body_exited(body):
	if body.name == "Player":
		interactable = false
