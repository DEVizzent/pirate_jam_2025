extends Control

const UPDATE_ICON_TIME : float = 2.0

@onready var faith_icon : TextureRect = $Panel/MarginContainer/HBoxContainer/FaithIcon
@onready var food_icon : TextureRect = $Panel/MarginContainer/HBoxContainer/FoodIcon
@onready var force_icon : TextureRect = $Panel/MarginContainer/HBoxContainer/ForceIcon

var pagan_icon: Texture2D = load("res://Character Models/textures/ICONS/runa64.png")

func _ready() -> void:
	update_faith(0, KingdomStats.faith)
	update_food(0, KingdomStats.food)
	update_force(0, KingdomStats.force)
	EventBus.faith_changed.connect(update_faith)
	EventBus.food_changed.connect(update_food)
	EventBus.force_changed.connect(update_force)
	EventBus.pagan_state.connect(change_to_pagan)
	EventBus.run_started.connect(show_animated)

func update_faith(_from: int, to : int) -> void:
	tween_update(faith_icon, to)
func update_food(_from: int, to : int) -> void:
	tween_update(food_icon, to)
func update_force(_from: int, to : int) -> void:
	tween_update(force_icon, to)
func change_to_pagan() -> void:
	faith_icon.texture = pagan_icon

func tween_update(icon : TextureRect, to: int) -> void:
	var tween : Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(icon, "material:shader_parameter/stat_value", float(to), UPDATE_ICON_TIME)

func show_animated() -> void:
	position.y -= 100
	visible = true
	var tween : Tween = create_tween()
	tween.tween_property(self, 'position', position + Vector2(0., 100), 1.)
