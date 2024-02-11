extends Node

class_name PlayerHistory

var direction: Vector2
var object: TileObject
var is_interacting: bool
var interaction_dir: Enums.AXIS
var position: Vector2


func _init(
	dir: Vector2, obj: TileObject, interacting: bool, interact_dir: Enums.AXIS, pos: Vector2
) -> void:
	direction = dir
	object = obj
	is_interacting = interacting
	interaction_dir = interact_dir
	position = pos
