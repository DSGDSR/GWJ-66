extends CanvasLayer

@onready var _player := Utils.get_player()
@onready var _interact := $Actions/ActionList/Interact
@onready var _undo := $Actions/ActionList/Undo
@onready var _movements: Label = $Movements/MovementsLabel


func refresh() -> void:
	_on_player_move()


func _ready() -> void:
	_player.moved.connect(_on_player_move)
	_player.interacted.connect(_update_interact_label)
	LevelManager.movements_change.connect(_on_movements_change)


func _on_player_move() -> void:
	_update_interact_label()
	_interact.toggle(!!_player.object)
	_undo.toggle(!!HistoryManager.get_last())


func _on_movements_change(movements: int) -> void:
	_movements.text = (str(movements) + " movements")
	_movements.modulate = Color.INDIAN_RED if !LevelManager.get_score() else Color.WHITE


func _update_interact_label(_interacting := false) -> void:
	if _player.object:
		if _player.is_interacting:
			_interact.set_label("RELEASE")
		else:
			_interact.set_label(_player.object.custom_name.to_upper())
	else:
		_interact.set_label("")
