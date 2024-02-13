extends TileMap

class_name TileObject

@onready var _parent: Area2D = get_parent()

@export var custom_name: String
@export var test: int
@export var hi: bool

var _last_pos: Vector2
var _first_event_emitted: bool = true
var _animation_tween: Tween
var _movement_action: Enums.MOVEMENT_ACTION


func _ready() -> void:
	_parent.body_entered.connect(_on_body_entered)


func move(dir: Vector2, animation_time: float, increase = MIDI_MESSAGE_TUNE_REQUEST) -> void:
	_movement_action = Enums.MOVEMENT_ACTION.MOVE if increase else Enums.MOVEMENT_ACTION.UNDO
	var pos = _parent.position + dir * Constants.TILE_SIZE
	_last_pos = _parent.position
	_animation_tween = Utils.animate_position(_parent, pos, animation_time)
	_animation_tween.finished.connect(_movememt_finished)


func _movememt_finished() -> void:
	_animation_tween.finished.disconnect(_movememt_finished)
	LevelManager.increase_movements(+1 if _movement_action == Enums.MOVEMENT_ACTION.MOVE else -1)


func _on_body_entered(_body) -> void:
	if _first_event_emitted:
		_first_event_emitted = false
		return

	if _animation_tween:
		_animation_tween.kill()
		_animation_tween = null
		Utils.get_player().cancel_movement()
		HistoryManager.step_back()

	_parent.position = _last_pos
