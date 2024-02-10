extends Node

# Level container
@onready var _level_container = get_tree().get_nodes_in_group("Level")[0]
@onready var _player = get_tree().get_nodes_in_group("Player")[0]

var _current_level: Enums.LEVELS


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


func restart() -> void:
	_remove_current_level()
	load_level(_current_level)
	_player.reset()


func _remove_current_level() -> void:
	for n in _level_container.get_children():
		_level_container.remove_child(n)
		n.queue_free()
