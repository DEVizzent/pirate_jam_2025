extends Resource
class_name GameCandidates

@export var tutorial_candidates : Array[Candidate]
@export var early_game_candidates : Array[Candidate]
@export var mid_game_candidates : Array[Candidate]
@export var late_game_candidates : Array[Candidate]
@export var end_game_candidates : Array[Candidate]

func get_candidates_by_turn(turn : GameFlow.Turn) -> Array[Candidate]:
	match turn:
		GameFlow.Turn.TUTORIAL:
			return tutorial_candidates
		GameFlow.Turn.FIRST:
			return get_early_game_candidates(3)
		GameFlow.Turn.SECOND:
			return get_mid_game_candidates(3, 1, 0)
		GameFlow.Turn.THIRD:
			return get_mid_game_candidates(4, 0, 0)
		GameFlow.Turn.FOURTH:
			return get_mid_game_candidates(3, 0, 1)
		GameFlow.Turn.FIVETH:
			return get_late_game_candidates(3, 1)
		GameFlow.Turn.SIXTH:
			return get_late_game_candidates(3, 1)
		GameFlow.Turn.PLUS:
			return get_late_game_candidates(3, 1)
		_:
			push_error("No turn matched to get candidates")
			return get_late_game_candidates(3, 1)

func get_early_game_candidates(number: int) -> Array[Candidate]:
	return _get_n_candidates_in_collection(number, early_game_candidates)

func get_mid_game_candidates(number: int, previous_collection_number: int, next_collection_number: int) -> Array[Candidate]:
	var candidates : Array[Candidate] = _get_n_candidates_in_collection(number, mid_game_candidates)
	if previous_collection_number > 0:
		candidates.append_array(_get_n_candidates_in_collection(previous_collection_number, early_game_candidates))
	if next_collection_number > 0:
		candidates.append_array(_get_n_candidates_in_collection(next_collection_number, late_game_candidates))
	return candidates

func get_late_game_candidates(number: int, next_collection_number: int) -> Array[Candidate]:
	var candidates : Array[Candidate] = _get_n_candidates_in_collection(number, late_game_candidates)
	if next_collection_number > 0:
		candidates.append_array(_get_n_candidates_in_collection(next_collection_number, end_game_candidates))
	return candidates
	
func _get_n_candidates_in_collection(n: int, collection: Array[Candidate]) -> Array[Candidate]:
	#TODO: Implement a logic to get random candidates based on game logic
	collection.shuffle()
	return collection.slice(0, n)
