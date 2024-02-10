extends Node

# Level container
@onready var _level_container = get_tree().get_nodes_in_group("Level")[0]

var _current_level: Enums.LEVELS


func load_level(level: Enums.LEVELS = Enums.LEVELS.Tutorial):
	_current_level = level
	_remove_current_level()
	var new_level = await load("res://levels/" + Enums.LEVELS.keys()[level] + ".tscn").instantiate()
	_level_container.add_child(new_level)


func restart() -> void:
	_remove_current_level()
	load_level(_current_level)
	Utils.get_player().reset()


func _remove_current_level() -> void:
	for n in _level_container.get_children():
		_level_container.remove_child(n)
		n.queue_free()
