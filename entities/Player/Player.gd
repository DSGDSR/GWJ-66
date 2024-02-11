extends Area2D

class_name Player

@onready var _ray = $RayCast2D

# Properties to be saved
var direction: Vector2 = Vector2.ZERO
var object: TileObject = null
var is_interacting: bool = false
var interaction_dir: Enums.AXIS

var _moving = false
var _animation_tween: Tween


func move(input: String, animation_time: float, save := true) -> void:
	if _moving:
		return

	var prev_direction = direction
	var was_colliding = _ray.is_colliding()

	update_direction(Constants.INPUTS[input])

	if prev_direction == direction && was_colliding && !is_interacting:
		_detect_collision()
		return

	if !is_interacting:
		if !_ray.is_colliding():
			_move(direction, animation_time, true)
		_detect_collision()
	elif _can_move_with_object(direction):
		_move(direction, animation_time)
		object.move(direction, animation_time, save)

	if save:
		_save_state()


func update_direction(dir: Vector2) -> void:
	direction = dir
	_ray.target_position = dir * Constants.TILE_SIZE
	_ray.force_raycast_update()


func reset() -> void:
	# position = Vector2.ZERO TODO inherit position from level info
	_ray.force_raycast_update()
	object = null
	is_interacting = false
	interaction_dir = Enums.AXIS.Y


func set_snapped_position(pos: Vector2) -> void:
	position = pos.snapped(Vector2.ONE * Constants.TILE_SIZE)
	position += Vector2.ONE * Constants.TILE_SIZE / 2


func enable_movement() -> void:
	_moving = false


func cancel_movement() -> void:
	_animation_tween.kill()
	enable_movement()


func _move(dir: Vector2, animation_time: float, detect_collision = false) -> void:
	var pos = position + dir * Constants.TILE_SIZE
	_moving = true
	_animation_tween = Utils.animate_position(self, pos, animation_time, true)
	if detect_collision:
		_animation_tween.finished.connect(_detect_collision)


func _input(event: InputEvent) -> void:
	if event && event.is_action_pressed("interact"):
		if object and !is_interacting:
			object.interact()
			is_interacting = true
			interaction_dir = Constants.DIRECTION_TO_AXIS[direction]
		elif is_interacting:
			is_interacting = false
		get_viewport().set_input_as_handled()
	elif Input.is_action_pressed("undo") && !_moving:
		HistoryManager.undo()
		get_viewport().set_input_as_handled()
	else:
		_handle_move()


func _handle_move() -> void:
	for dir in Constants.INPUTS.keys():
		if Input.is_action_pressed(dir):
			move(dir, Constants.ANIMATION_TIME)


func _detect_collision() -> void:
	_ray.force_raycast_update()
	var collider = _ray.get_collider()
	if collider is TileObject:
		object = collider as TileObject
	else:
		object = null


func _can_move_with_object(dir: Vector2) -> bool:
	return (
		Constants.DIRECTION_TO_AXIS[dir] == interaction_dir
		&& (!_ray.is_colliding() || _ray.get_collider() == object)
	)


func _save_state() -> void:
	HistoryManager.add_to_history(
		PlayerHistory.new(direction, object, is_interacting, interaction_dir, position)
	)
