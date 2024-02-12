extends Node

@onready var _player := Utils.get_player()

var _history: Array[Node] = []


func add_to_history(pos: Node) -> void:
	_history.append(pos)


func get_last():
	if _history.size() > 0:
		return _history[_history.size() - 1]
	else:
		return null


func clear() -> void:
	if _history.size() > 0:
		_history.clear()


func remove_last() -> Node:
	return _history.pop_back()


func step_back() -> void:
	if _history.size() > 0:
		# Get player back to previous position
		_player.position = remove_last().position


func undo() -> void:
	if _history.size() > 0:
		# Get player back to previous position with animation
		var last = remove_last()
		if last is PlayerHistory:
			# If last is a PlayerHistory, we need to undo the player's state
			_undo_player(last)
		else:
			# If last is a Node, we need to undo the object's state
			pass


func _undo_player(last: PlayerHistory) -> void:
	_player.is_interacting = last.is_interacting
	_player.interaction_dir = last.interaction_dir
	_player.object = last.object
	if last.position != _player.position:
		var last_movement = Constants.INPUTS.find_key(Vector2.ZERO - last.direction)
		_player.move(last_movement, Constants.UNDO_ANIMATION_TIME, true)

	var previous = get_last()
	var prev_direction = previous.direction if previous else Vector2.ZERO
	_player.direction = prev_direction
	_player.update_direction(prev_direction)
	if !last.is_interacting:
		_player._update_sprite_frame()
