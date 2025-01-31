extends Node

@export var sfx_resource_collection : SfxResourceCollection
var sfx_dictionary : Dictionary
var audio_stream_pool : Array[AudioStreamPlayer]
var audio_stream_loaded_tracks : Array[String]
var current_stream : int = 0
var pool_size : int

func _ready() -> void:
	sfx_dictionary = sfx_resource_collection.get_dictionary()
	audio_stream_pool.append($AudioStreamPlayer)
	audio_stream_loaded_tracks.append("")
	audio_stream_pool.append($AudioStreamPlayer1)
	audio_stream_loaded_tracks.append("victory")
	audio_stream_pool.append($AudioStreamPlayer2)
	audio_stream_loaded_tracks.append("defeat")
	audio_stream_pool.append($AudioStreamPlayer3)
	audio_stream_loaded_tracks.append("click")
	pool_size = audio_stream_pool.size()
	
	for streamplayer in audio_stream_pool:
		streamplayer.finished.connect(resetvol)

func play(sfx_name : StringName) -> void:
	if sfx_name == "victory" or sfx_name == "defeat":
		MusicController.lower_volume()
	var loaded_stream_index_pool : int = audio_stream_loaded_tracks.find(sfx_name)
	if loaded_stream_index_pool != -1:
		audio_stream_pool[loaded_stream_index_pool].play()
		return
	if not sfx_dictionary[sfx_name] is AudioStreamOggVorbis:
		print_debug("Sound '" + sfx_name + "' not found")
		return
	audio_stream_pool[current_stream].stream = sfx_dictionary[sfx_name]
	audio_stream_loaded_tracks[current_stream] = sfx_name
	audio_stream_pool[current_stream].play()
	current_stream = (current_stream + 1) % pool_size

func resetvol():
	MusicController.fade_in()
