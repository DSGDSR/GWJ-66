extends VBoxContainer

@onready var _start: Button = $Start
@onready var _restart: Button = $Restart
@onready var _quit: Button = $Quit


func _ready() -> void:
	var first_button: Button = get_children()[0]
	first_button.grab_focus()


func _process(_delta):
	if LevelManager.GAME_STATE == Enums.GAME_STATE.PAUSE_MENU:
		_start.text = "Resume"
		_restart.visible = true
		_quit.text = "Quit to menu"
	else:
		_start.text = "Start"
		_restart.visible = false
		_quit.text = "Quit"
