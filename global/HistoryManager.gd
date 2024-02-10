extends Node

var _history: Array[Vector2] = []


func add_to_history(pos: Vector2) -> void:
	_history.append(pos)


func get_last() -> Vector2:
	if _history.size() > 0:
		return _history[_history.size() - 1]
	else:
		return Vector2(0, 0)


func get_history() -> Array[Vector2]:
	return _history


func clear_history() -> void:
	if _history.size() > 0:
		_history.clear()


func remove_last() -> void:
	if _history.size() > 0:
		_history.pop_back()


func step_back() -> void:
	if _history.size() > 0:
		remove_last()
		# Get player back to previous position
		Utils.get_player().position = get_last()
