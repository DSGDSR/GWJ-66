extends CanvasLayer

@onready var splash: Control = $Splash
@onready var menu: Control = $Menu


func start_game() -> void:
	menu.visible = true
	splash.start()
