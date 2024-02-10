extends Area2D

@onready var ray = $RayCast2D

var direction: Vector2 = Vector2.DOWN

const INPUTS: Dictionary = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

func move(dir):
	ray.target_position = INPUTS[dir] * Globals.TILE_SIZE
	ray.force_raycast_update()
	direction = INPUTS[dir]
	if !ray.is_colliding():
		position += INPUTS[dir] * Globals.TILE_SIZE
	_detect_collision()

func _ready():
	position = position.snapped(Vector2.ONE * Globals.TILE_SIZE)
	position += Vector2.ONE * Globals.TILE_SIZE/2

func _detect_collision():
	ray.force_raycast_update()
	var collider = ray.get_collider()
	if collider is TileMap:
		var tilemap = collider as TileMap
		print(tilemap.name)

func _unhandled_input(event):
	for dir in INPUTS.keys():
		if event.is_action_pressed(dir):
			move(dir)
