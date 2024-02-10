extends Node

enum MENU_STATE {
	START,
	PAUSE
}

enum WINDOW_MODE {
	FULLSCREEN,
	WINDOW,
	BORDERLESS_FS,
	BORDERLESS_WINDOW
}

const FPS_LIMIT: Dictionary = {
	'No limit': 0,
	'30': 30,
	'60': 60,
	'120': 120
}

const WINDOW_MODE_LABEL: Dictionary = {
	WINDOW_MODE.FULLSCREEN: 'Fullscreen',
	WINDOW_MODE.WINDOW: 'Window',
	WINDOW_MODE.BORDERLESS_FS: 'Borderless fullscreen',
	WINDOW_MODE.BORDERLESS_WINDOW: 'Borderless window',
}

const WINDOW_RESOLUTION: Dictionary = {
	'2560 × 1440': Vector2i(2560, 1440),
	'1920 x 1080': Vector2i(1920, 1080),
	'1600 x 900': Vector2i(1600, 900),
	'1280 x 720': Vector2i(1280, 720),
	'960 x 540': Vector2i(960, 540),
	'640 x 360': Vector2i(640, 360)
}

const GAME_INPUTS: Dictionary = {
	'ui_accept': 'Accept (UI)',
	'ui_cancel': 'Go back (UI)',
	'move_up': 'Move up',
	'move_right': 'Move right',
	'move_down': 'Move down',
	'move_left': 'Move left',
}
