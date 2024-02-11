extends Node

const ANIMATION_TIME = 8.5
const UNDO_ANIMATION_TIME = 15.0

const TILE_SIZE = 32

const INPUTS: Dictionary = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

const DIRECTION_TO_AXIS: Dictionary = {
	Vector2.UP: Enums.AXIS.Y,
	Vector2.DOWN: Enums.AXIS.Y,
	Vector2.RIGHT: Enums.AXIS.X,
	Vector2.LEFT: Enums.AXIS.X
}

const DIRECTION_TO_FRAME: Dictionary = {
	Vector2.ZERO: Enums.PLAYER_FRAMES.IDLE,
	Vector2.UP: Enums.PLAYER_FRAMES.TOP,
	Vector2.DOWN: Enums.PLAYER_FRAMES.BOTTOM,
	Vector2.RIGHT: Enums.PLAYER_FRAMES.RIGHT,
	Vector2.LEFT: Enums.PLAYER_FRAMES.LEFT
}

const WINDOW_MODE_LABEL: Dictionary = {
	Enums.WINDOW_MODE.FULLSCREEN: "Fullscreen",
	Enums.WINDOW_MODE.WINDOW: "Window",
	Enums.WINDOW_MODE.BORDERLESS_FS: "Borderless fullscreen",
	Enums.WINDOW_MODE.BORDERLESS_WINDOW: "Borderless window",
}

const WINDOW_RESOLUTION: Dictionary = {
	"2560 × 1440": Vector2i(2560, 1440),
	"1920 x 1080": Vector2i(1920, 1080),
	"1600 x 900": Vector2i(1600, 900),
	"1280 x 720": Vector2i(1280, 720),
	"960 x 540": Vector2i(960, 540),
	"640 x 360": Vector2i(640, 360)
}

const GAME_INPUTS: Dictionary = {
	"ui_accept": "Accept (UI)",
	"ui_cancel": "Go back (UI)",
	"move_up": "Move up",
	"move_right": "Move right",
	"move_down": "Move down",
	"move_left": "Move left",
}
