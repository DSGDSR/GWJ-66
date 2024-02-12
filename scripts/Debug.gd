extends Control

@onready var _interaction: Label = $VBoxContainer/Interaction
@onready var _direction: Label = $VBoxContainer/Direction
@onready var _object: Label = $VBoxContainer/Object


func _process(_delta) -> void:
	visible = Constants.DEBUG
	if visible:
		# Get player by group
		var player = get_tree().get_nodes_in_group("Player")[0]
		_interaction.text = "Is interacting: " + str(player.is_interacting)
		_direction.text = "Direction: " + str(player.direction)
		_object.text = (
			"Object: " + str(player.object.custom_name if (player && player.object) else "None")
		)
