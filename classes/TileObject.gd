extends TileMap

class_name TileObject

@onready var _parent: Area2D = get_parent()

@export var custom_name: String
@export var test: int
@export var hi: bool

var _last_pos: Vector2
var _first_event_emitted: bool = true
var _animation_tween: Tween


func _ready() -> void:
	_parent.body_entered.connect(_on_body_entered)


func interact() -> void:
	print("interacting with " + custom_name)


func move(dir: Vector2):
	var pos = _parent.position + dir * Constants.TILE_SIZE
	_last_pos = _parent.position
	_animation_tween = Utils.animate_position(_parent, pos)


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
