extends Area2D

class_name Player

@onready var ray = $RayCast2D

var direction: Vector2 = Vector2.DOWN
var object: TileObject = null
var is_interacting: bool = false
var interaction_dir: Enums.AXIS


func move(input: String) -> void:
	var dir = Constants.INPUTS[input]

	ray.target_position = dir * Constants.TILE_SIZE
	ray.force_raycast_update()
	direction = dir

	if !is_interacting:
		if !ray.is_colliding():
			_move(dir)
		_detect_collision()
	elif _can_move_with_object(dir):
		_move(dir)
		object.move(dir)


func _move(dir: Vector2) -> void:
	position += dir * Constants.TILE_SIZE
	HistoryManager.add_to_history(position)


func _ready() -> void:
	position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position += Vector2.ONE * Constants.TILE_SIZE / 2


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if object and !is_interacting:
			object.interact()
			is_interacting = true
			interaction_dir = Constants.DIRECTION_TO_AXIS[direction]
		elif is_interacting:
			is_interacting = false

		get_viewport().set_input_as_handled()
	else:
		for dir in Constants.INPUTS.keys():
			if event.is_action_pressed(dir):
				move(dir)


func _detect_collision() -> void:
	ray.force_raycast_update()
	var collider = ray.get_collider()
	if collider is TileObject:
		object = collider as TileObject
	else:
		object = null


func _can_move_with_object(dir: Vector2) -> bool:
	return (
		Constants.DIRECTION_TO_AXIS[dir] == interaction_dir
		&& (!ray.is_colliding() || ray.get_collider() == object)
	)
