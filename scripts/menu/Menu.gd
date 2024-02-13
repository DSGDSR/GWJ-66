extends Control

@onready var _options = $Options
@onready var _levels = $Levels
@onready var _buttons = $Buttons
@onready var _credits = $"../Credits"


func toggle() -> void:
	if LevelManager.GAME_STATE == Enums.GAME_STATE.START_MENU:
		return

	if visible:
		hide_menu()
	else:
		pause()


func back() -> void:
	if _options.visible:
		toggle_options(false)
	elif LevelManager.GAME_STATE == Enums.GAME_STATE.PAUSE_MENU:
		hide_menu()


func _ready() -> void:
	# Setup initial state
	_buttons.visible = true
	_options.visible = false
	_levels.visible = false
	_credits.visible = false

	# Setup buttons signals
	$Buttons/Start.pressed.connect(_start)
	$Buttons/Restart.pressed.connect(_restart)
	$Buttons/Options.pressed.connect(toggle_options.bind(true))
	$Buttons/Quit.pressed.connect(_quit)
	$Buttons/Credits.pressed.connect(toggle_credits.bind(true))


func pause() -> void:
	visible = true
	_buttons.visible = true
	_options.visible = false
	LevelManager.GAME_STATE = Enums.GAME_STATE.PAUSE_MENU
	_buttons.get_children()[0].grab_focus()


func hide_menu() -> void:
	visible = false
	_options.visible = false
	_levels.visible = false
	LevelManager.GAME_STATE = Enums.GAME_STATE.GAME_ONGOING


func toggle_options(state: bool) -> void:
	_options.visible = state


func _start() -> void:
	if LevelManager.GAME_STATE == Enums.GAME_STATE.START_MENU:
		_buttons.visible = false
		_levels.visible = true
	else:
		visible = false
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


func toggle_credits(_state: bool) -> void:
	_credits.visible = _state
	if _state:
		LevelManager.GAME_STATE = Enums.GAME_STATE.CREDITS
	else:
		LevelManager.GAME_STATE = Enums.GAME_STATE.START_MENU
		_credits.stop()
