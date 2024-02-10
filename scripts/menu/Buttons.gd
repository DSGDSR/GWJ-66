extends VBoxContainer

func _ready() -> void:
	var first_button: Button = get_children()[0]
	first_button.grab_focus()
