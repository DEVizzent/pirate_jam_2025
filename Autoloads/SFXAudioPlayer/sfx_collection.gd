extends Resource
class_name SfxResourceCollection

@export var sfx_resources : Array[SfxResource]

func get_dictionary() -> Dictionary:
	var sfx_dictionary = {}
	for sfx_resource in sfx_resources:
		sfx_dictionary[sfx_resource.sfx_name] = sfx_resource.sfx_stream
	return sfx_dictionary
