extends Node

signal device_changed(device: Enums.DEVICE)

@onready var _player := Utils.get_player()
@onready var _menu := Utils.get_menu()

var _device = Enums.DEVICE.KEYBOARD


func _input(event: InputEvent) -> void:
	# DETECT DEVICE
	if event is InputEventKey || event is InputEventMouse:
		_change_device(Enums.DEVICE.KEYBOARD)
	elif event is InputEventJoypadButton:
		_change_device(Enums.DEVICE.GAMEPAD)

	# CONTROLS
	if (
		LevelManager.GAME_STATE == Enums.GAME_STATE.START_MENU
		|| LevelManager.GAME_STATE == Enums.GAME_STATE.PAUSE_MENU
	):
		if event.is_action_pressed("ui_cancel"):
			_menu.cancel()
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.GAME_SELECTION:
		pass
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.GAME_ONGOING:
		if event && event.is_action_pressed("interact"):
			_player._interact()
			get_viewport().set_input_as_handled()
		elif Input.is_action_pressed("undo") && !_player._moving:
			HistoryManager.undo()
			get_viewport().set_input_as_handled()
		else:
			_player._handle_move()


func _change_device(device: Enums.DEVICE) -> void:
	if _device != device:
		_device = device
		device_changed.emit(device)
