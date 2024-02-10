extends Node

@onready var _player := Utils.get_player()

var _history: Array[Dictionary] = []


func add_to_history(pos: Dictionary) -> void:
	_history.append(pos)


func get_last():
	if _history.size() > 0:
		return _history[_history.size() - 1]
	else:
		return null


func clear_history() -> void:
	if _history.size() > 0:
		_history.clear()


func remove_last() -> Dictionary:
	return _history.pop_back()


func undo() -> void:
	if _history.size() > 0:
		# Get player back to previous position with animation
		var last = remove_last()

		print(
			(
				"GET: Is interacting: "
				+ str(last.interacting)
				+ " | Direction: "
				+ str(last.direction)
				+ " | Position: "
				+ str(last.position)
			)
		)

		_player.is_interacting = last.interacting
		_player.object = last.object
		if last.position != _player.position:
			var last_movement = Constants.INPUTS.find_key(Vector2.ZERO - last.direction)
			_player.move(last_movement, false)

		var previous = get_last()
		var prev_direction = previous.direction if previous else Vector2.ZERO
		_player.direction = prev_direction
		_player.update_direction(prev_direction)


func step_back() -> void:
	if _history.size() > 0:
		# Get player back to previous position
		_player.position = remove_last().position
