extends Node

# Level container
@onready var _level_container: Node2D = get_tree().get_first_node_in_group("Level")
@onready var _player: Player = get_tree().get_first_node_in_group("Player")
@onready var _timer: Timer = get_tree().get_first_node_in_group("Timer")

var _current_level: Enums.LEVELS
var _time := 0.0
var _movements := 0


func load_level(level: Enums.LEVELS = Enums.LEVELS.Tutorial):
	_current_level = level
	_remove_current_level()
	var new_level: TileLevel = (
		await load("res://levels/" + Enums.LEVELS.keys()[level] + ".tscn").instantiate()
		as TileLevel
	)
	_level_container.add_child(new_level)
	_player.set_snapped_position(new_level.player_position)
	_player.visible = true
	# _start_timer() TODO Do we want to have a timer?


func restart() -> void:
	_remove_current_level()
	load_level(_current_level)
	_player.reset()


func increase_movements(movements: int) -> void:
	_movements += movements
	print("Movements: " + str(_movements))


func get_movements() -> int:
	return _movements


func _start_timer() -> void:
	_stop_timer()
	_timer.timeout.connect(_on_timer_timeout)
	_timer.start()


func _stop_timer() -> void:
	_timer.stop()
	_time = 0.0
	if _timer.timeout.is_connected(_on_timer_timeout):
		_timer.timeout.disconnect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	_time += _timer.wait_time
	print("Time: " + str(_time))


func _remove_current_level() -> void:
	for n in _level_container.get_children():
		_level_container.remove_child(n)
		n.queue_free()
