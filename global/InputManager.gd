extends Node

signal device_changed(device: Enums.DEVICE)

@onready var _player := Utils.get_player()
@onready var _menu := Utils.get_menu()

var _device = Enums.DEVICE.KEYBOARD


func _input(event: InputEvent) -> void:
	_detect_device(event)

	# MENU CONTROLS
	if LevelManager.GAME_STATE == Enums.GAME_STATE.SPLASH:
		if event.is_action_pressed("ui_accept") || event.is_action_pressed("ui_cancel"):
			get_tree().get_first_node_in_group("Splash").stop()
			get_viewport().set_input_as_handled()
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.START_MENU:
		if event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_back"):
			_menu.back()
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.PAUSE_MENU:
		if event.is_action_pressed("ui_cancel"):
			_menu.toggle()
			get_viewport().set_input_as_handled()
		elif event.is_action_pressed("ui_back"):
			_menu.back()
			get_viewport().set_input_as_handled()

	# GAME CONTROLS
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.GAME_ONGOING:
		if event.is_action_pressed("ui_cancel"):
			_menu.toggle()
			get_viewport().set_input_as_handled()
		elif event && event.is_action_pressed("interact"):
			_player._interact()
			get_viewport().set_input_as_handled()
		elif Input.is_action_pressed("undo") && !_player._moving:
			HistoryManager.undo()
			get_viewport().set_input_as_handled()
		else:
			_player._handle_move()

	# LEVEL SELECTION
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.GAME_SELECTION:
		pass

	# CREDITS
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.CREDITS:
		if (
			event.is_action_pressed("ui_accept")
			|| event.is_action_pressed("ui_cancel")
			|| event.is_action_pressed("ui_back")
		):
			_menu.toggle_credits(false)


func _detect_device(event: InputEvent) -> void:
	# DETECT DEVICE
	if event is InputEventKey || event is InputEventMouse:
		_change_device(Enums.DEVICE.KEYBOARD)
	elif event is InputEventJoypadButton:
		_change_device(Enums.DEVICE.GAMEPAD)


func _change_device(device: Enums.DEVICE) -> void:
	if _device != device:
		_device = device
		device_changed.emit(device)
