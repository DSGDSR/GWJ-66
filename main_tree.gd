extends Node2D

@onready var controls = $Controls


# GAME STARTS
func _ready() -> void:
	# Set max fps
	Engine.set_max_fps(30)

	# Run splashes and show controls
	controls.visible = true
	controls.start_game()
