extends AudioStreamPlayer

var is_fading_in = false
const speed_fading = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # We can connect the controller to events

func switch_to_menu_song() -> void:
	self["parameters/switch_to_clip"] = "MenuSong"
func switch_to_level_song() -> void:
	self["parameters/switch_to_clip"] = "LevelSong"

#Simple, not elegant solution to get a music fade in after victory/defeat themes
func _process(delta: float) -> void:
	if is_fading_in:
		volume_db += speed_fading * delta
		if volume_db >= 0:
			volume_db = 0
			is_fading_in = false

#To start back / lower the volume
func fade_in() -> void:
	is_fading_in = true

func lower_volume():
	volume_db = -10
