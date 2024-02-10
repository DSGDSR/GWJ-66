extends Control

var menu_state

@onready var options = $Options

func _ready() -> void:
	menu_state = Enums.MENU_STATE.START

func _input(event: InputEvent) -> void:
	# Handle cancel action
	if event.is_action_pressed('ui_cancel') && (options.visible || visible):
		get_viewport().set_input_as_handled()
		if options.visible:
			_toggle_options(false)
		elif menu_state == Enums.MENU_STATE.PAUSE:
			visible = false

func _toggle_options(state: bool) -> void:
	options.visible = state

func _quit() -> void:
	get_tree().quit()
