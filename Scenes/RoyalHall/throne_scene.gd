extends Node3D

@onready var sm_cross_gold: MeshInstance3D = $SmCrossGold
@onready var sm_cross_simple: MeshInstance3D = $SmCrossSimple
@onready var sm_pagan_statue_hastur: MeshInstance3D = $SmPaganStatueHastur
@onready var sm_pagan_statue_satire: MeshInstance3D = $SmPaganStatueSatire

@onready var sm_throne_christian: MeshInstance3D = $SmThroneChristian
@onready var sm_throne_pagan: MeshInstance3D = $SmThronePagan
@onready var sm_throne_simple: MeshInstance3D = $SmThroneSimple
@onready var sm_throne_swords: MeshInstance3D = $SmThroneSwords

@onready var sm_treasure_chest: MeshInstance3D = $SmTreasureChest
@onready var sm_treasure_chest_2: MeshInstance3D = $SmTreasureChest2
@onready var sm_treasure_chest_3: MeshInstance3D = $SmTreasureChest3

var pagan_state : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.faith_changed.connect(faith_updated)
	EventBus.food_changed.connect(food_updated)
	EventBus.force_changed.connect(force_updated)
	EventBus.pagan_state.connect(activate_pagan_state)
	
func activate_pagan_state() -> void:
	pagan_state = true
	faith_updated(0,KingdomStats.faith)

func faith_updated(_from: int, to: int) -> void:
	if to < 7:
		sm_cross_simple.visible = not pagan_state
		sm_cross_gold.hide()
		sm_pagan_statue_satire.visible = pagan_state
		sm_pagan_statue_hastur.hide()
	else:
		sm_cross_gold.visible = not pagan_state
		sm_cross_simple.hide()
		sm_pagan_statue_hastur.visible = pagan_state
		sm_pagan_statue_satire.hide()

func food_updated(_from: int, to: int) -> void:
	if to < 2:
		sm_treasure_chest.hide()
		sm_treasure_chest_2.hide()
		sm_treasure_chest_3.hide()
	elif to < 4:
		sm_treasure_chest.show()
		sm_treasure_chest_2.hide()
		sm_treasure_chest_3.hide()
	elif to < 6:
		sm_treasure_chest.show()
		sm_treasure_chest_2.show()
		sm_treasure_chest_3.hide()
	else:
		sm_treasure_chest.show()
		sm_treasure_chest_2.show()
		sm_treasure_chest_3.show()
	pass

func force_updated(_from: int, to: int) -> void:
	if to < 2:
		$SmWeaponRack.hide()
		$SmWeaponRack2.hide()
	elif to < 5:
		$SmWeaponRack.show()
		$SmWeaponRack2.hide()
	else:
		$SmWeaponRack.show()
		$SmWeaponRack2.show()
	if to < 6:
		sm_throne_simple.show()
		sm_throne_pagan.hide()
		sm_throne_christian.hide()
		sm_throne_swords.hide()
	elif to < 8:
		sm_throne_simple.hide()
		sm_throne_pagan.visible = pagan_state
		sm_throne_christian.visible = not pagan_state
		sm_throne_swords.hide()
	else:
		sm_throne_simple.hide()
		sm_throne_pagan.hide()
		sm_throne_christian.hide()
		sm_throne_swords.show()
	pass
