extends Area2D

class_name Player

signal moved
signal interacted(state: bool)

@onready var _ray = $RayCast2D
@onready var _sprite = $Sprite2D

# Properties to be saved
var direction: Vector2 = Vector2.ZERO
var object: TileObject = null
var is_interacting: bool = false
var interaction_dir: Enums.AXIS

var _moving = false
var _animation_tween: Tween


func move(input: String, animation_time: float, undo := false) -> void:
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
		object.move(direction, animation_time, !undo)

	if !undo:
		_save_state()

	if is_interacting && !undo:
		update_direction(prev_direction)

	_update_sprite_frame()


func update_direction(dir: Vector2) -> void:
	direction = dir
	_ray.target_position = dir * Constants.TILE_SIZE
	_ray.force_raycast_update()


func _update_sprite_frame() -> void:
	var frame = Constants.DIRECTION_TO_FRAME[direction]
	_sprite.frame = frame + (4 if is_interacting else 0)


func reset() -> void:
	visible = true
	object = null
	is_interacting = false
	interaction_dir = Enums.AXIS.Y
	update_direction(Vector2.ZERO)
	_update_sprite_frame()


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
		_animation_tween.finished.connect(_on_animation_finished)
	else:
		moved.emit()


func _handle_move() -> void:
	for dir in Constants.INPUTS.keys():
		if Input.is_action_pressed(dir):
			move(dir, Constants.ANIMATION_TIME)


func _interact() -> void:
	if !object:
		return

	if !is_interacting:
		is_interacting = true
		interaction_dir = Constants.DIRECTION_TO_AXIS[direction]
		_save_state()
	elif is_interacting:
		is_interacting = false
	interacted.emit(is_interacting)
	_update_sprite_frame()


func _detect_collision() -> void:
	_ray.force_raycast_update()
	var collider = _ray.get_collider()
	if collider is TileObject:
		object = collider as TileObject
	else:
		object = null
	moved.emit()


func _on_animation_finished() -> void:
	_detect_collision()
	moved.emit()


func _can_move_with_object(dir: Vector2) -> bool:
	return (
		Constants.DIRECTION_TO_AXIS[dir] == interaction_dir
		&& (!_ray.is_colliding() || _ray.get_collider() == object)
	)


func _save_state() -> void:
	HistoryManager.add_to_history(
		PlayerHistory.new(direction, object, is_interacting, interaction_dir, position)
	)
