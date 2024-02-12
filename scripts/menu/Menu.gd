extends Control

@onready var _options = $Options
@onready var _buttons = $Buttons


func toggle() -> void:
	if LevelManager.GAME_STATE == Enums.GAME_STATE.START_MENU:
		return

	if visible:
		_hide()
	else:
		_pause()


func back() -> void:
	if _options.visible:
		_toggle_options(false)
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.PAUSE_MENU:
		_hide()


func _pause() -> void:
	visible = true
	_options.visible = false
	LevelManager.GAME_STATE = Enums.GAME_STATE.PAUSE_MENU
	_buttons.get_children()[0].grab_focus()


func _hide() -> void:
	visible = false
	_options.visible = false
	LevelManager.GAME_STATE = Enums.GAME_STATE.GAME_ONGOING


func _toggle_options(state: bool) -> void:
	_options.visible = state


func _start() -> void:
	visible = false
	if LevelManager.GAME_STATE == Enums.GAME_STATE.START_MENU:
		LevelManager.load_level()
	else:
		LevelManager.GAME_STATE = Enums.GAME_STATE.GAME_ONGOING


func _restart() -> void:
	visible = false
	LevelManager.restart()


func _quit() -> void:
	if LevelManager.GAME_STATE == Enums.GAME_STATE.START_MENU:
		get_tree().quit()
	else:
		LevelManager.quit()
		LevelManager.GAME_STATE = Enums.GAME_STATE.START_MENU
