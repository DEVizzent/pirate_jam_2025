extends CharacterBody2D


const SPEED = 300.0
var direction : String
var idle: bool
var waiting: bool
@export var wait_time: float
var wait_timer : float
@onready var anim : AnimatedSprite2D = get_node("AnimatedSprite2D")


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionH = Input.get_axis("ui_left", "ui_right")
	var directionV = Input.get_axis("ui_up", "ui_down")
	if directionH:
		idle = false
		waiting = false
		if directionH > 0:
			direction = "East"
		else:
			direction = "West"
		velocity.x = directionH * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionV:
		idle = false
		waiting = false
		if directionV > 0:
			direction = "South"
		else:
			direction = "North"
		velocity.y = directionV * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if not idle and not waiting:
		wait_timer = 0
		waiting = true
	if not idle and waiting:
		wait_timer += delta
		if wait_timer > wait_time:
			idle = true
	#Animation

	if idle:
		anim.play("Idle")
	else:
		if direction == "East":
			anim.play("WalkingEast")
		if direction == "West":
			anim.play("WalkingWest")
		if direction == "North":
			anim.play("WalkingNorth")
		if direction == "South":
			anim.play("WalkingSouth")
	
	move_and_slide()
