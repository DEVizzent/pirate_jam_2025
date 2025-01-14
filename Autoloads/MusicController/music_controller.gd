extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # We can connect the controller to events

func switch_to_menu_song() -> void:
	self["parameters/switch_to_clip"] = "MenuSong"
func switch_to_level_song() -> void:
	self["parameters/switch_to_clip"] = "LevelSong"
