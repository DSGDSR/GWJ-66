extends HBoxContainer

@onready var _key_enabled := $Key/Sprite
@onready var _label := $Label

@export var frame := 0
@export var label := "Label"

var _frame := 0


func _ready() -> void:
	visible = false
	_frame = frame
	_set_sprite_frame()
	_label.text = label
	InputManager.device_changed.connect(_on_device_changed)


func toggle(state: bool) -> void:
	visible = state


func set_label(new_label: String) -> void:
	_label.text = new_label


func _on_device_changed(device: Enums.DEVICE) -> void:
	_frame = frame if device == Enums.DEVICE.KEYBOARD else (frame + 1)
	_set_sprite_frame()


func _set_sprite_frame() -> void:
	_key_enabled.frame = _frame
