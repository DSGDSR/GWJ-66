extends CanvasLayer

@onready var splash: Control = $Splash;

func run_splash() -> void:
	splash.start()
