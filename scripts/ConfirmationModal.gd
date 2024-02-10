extends Node

@onready var modal = $ConfirmationDialog

signal modal_signal

func open_modal(modal_opts: Modal) -> Signal:
	modal.title = modal_opts.title
	modal.dialog_text = modal_opts.text
	modal.cancel_button_text = modal_opts.cancel
	modal.ok_button_text = modal_opts.ok
	
	# Double toggle to center correctly (#TODO Godot bug to report)
	modal.visible = true
	modal.visible = false
	modal.visible = true
	
	# Focus window on open
	#get_window().grab_focus()
	
	return modal_signal

func _ready() -> void:
	modal.visible = false

func _on_confirmed() -> void:
	modal_signal.emit(true)

func _on_confirmation_dialog_canceled() -> void:
	modal_signal.emit(false)
