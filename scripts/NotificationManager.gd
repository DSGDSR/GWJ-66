extends Node

@onready var modal = $"../ConfirmationModal"

var _can_close: bool = true # TODO DISABLE FOR CONFIRMATION MODAL
var _modal_signal: Signal;

func _notification(event) -> void:
	match event:
		# Try to close app
		NOTIFICATION_WM_CLOSE_REQUEST:
			if _can_close:
				get_tree().quit()
			else:
				_can_close = true
				var confirm_modal = Modal.new()
				confirm_modal.text = 'Are you sure you want to force quit? Unsaved progress will be lost'
				_modal_signal = modal.open_modal(confirm_modal)
				_modal_signal.connect(_handle_close_request)
		_:
			pass

func _handle_close_request(accept: bool) -> void:
	if accept:
		get_tree().quit()
	else:
		_can_close = false
		_modal_signal.disconnect(_handle_close_request)
