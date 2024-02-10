extends Node2D

@onready var controls = $Controls

# GAME STARTS
func _ready() -> void:
	# Run splashes and show controls
	controls.visible = true
	controls.run_splash()
