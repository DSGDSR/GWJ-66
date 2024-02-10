extends Control

@onready var fps_counter = $FpsCounter
@onready var fps_checkbox = $TabsContainer/Tabs/General/OptionsContainer/DisplayFps

func _ready() -> void:
	_set_defaults()
	_setup_signals()

func _set_defaults() -> void:
	visible = false

func _setup_signals() -> void:
	fps_checkbox.pressed.connect(func(): fps_counter.visible = fps_checkbox.button_pressed)
