extends Node


func get_player() -> Player:
	return get_tree().get_first_node_in_group("Player")


func get_menu() -> Control:
	return get_tree().get_first_node_in_group("Menu")


func vector_is_null(v: Vector2) -> bool:
	return v.x == 0 && v.y == 0


func animate_position(node: Node, pos: Vector2, animation_time: float, is_player := false) -> Tween:
	var tween = create_tween()
	tween.tween_property(node, "position", pos, 1.0 / animation_time).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(func(): _on_tween_finished(tween, is_player))
	return tween


func _on_tween_finished(_tween: Tween, is_player = false) -> void:
	_tween.kill()
	if is_player:
		get_player().enable_movement()
