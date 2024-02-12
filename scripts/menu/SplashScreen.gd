extends Control

@export var splash_screens: Array[String] = []

@onready var splash_image: TextureRect = $SplashImage
@onready var splash_bg: ColorRect = $SplashBackground

var splash_tween: Tween


func start() -> Signal:
	const splash_finished = Signal()
	_run_splash(splash_finished)
	return splash_finished


func _ready() -> void:
	_set_defaults()


func _hide() -> void:
	# Change game state
	LevelManager.GAME_STATE = Enums.GAME_STATE.START_MENU

	# Enable to click buttons underneath
	splash_tween = create_tween()
	splash_image.visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$SplashBackground.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Hide splash BG
	splash_tween.tween_property(splash_bg, "modulate:a", 0, 1.5).set_ease(Tween.EASE_OUT)

	# Wait for tween to finish and kill it
	await splash_tween.finished
	splash_tween.kill()

	# Hide Splash control
	visible = false


func stop() -> void:
	splash_tween.kill()
	_hide()


func _run_splash(splash_finished: Signal) -> void:
	for splash in splash_screens:
		await _run_splash_screen(splash)
	_hide()
	splash_finished.emit()


func _run_splash_screen(splash: String) -> void:
	splash_tween = create_tween()

	# Load next image
	var image = Image.load_from_file("res://assets/splash/" + splash)
	splash_image.texture = ImageTexture.create_from_image(image)

	# Show splash
	(
		splash_tween
		. tween_property(splash_image, "modulate:a", 1, 0.75)
		. set_ease(Tween.EASE_IN)
		. set_delay(0.75)
	)
	(
		splash_tween
		. tween_property(splash_image, "modulate:a", 0, 2)
		. set_ease(Tween.EASE_OUT)
		. set_delay(1.5)
	)
	splash_tween.tween_interval(0.25)

	# Wait for tween to finish and kill it
	await splash_tween.finished
	splash_tween.kill()


func _set_defaults() -> void:
	# Base definitions
	visible = true
	splash_image.modulate.a = 0
	splash_bg.modulate.a = 1
	splash_bg.color = Color(0.067, 0.067, 0.067, 1)
