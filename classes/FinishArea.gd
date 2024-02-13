extends Area2D

class_name FinishArea


func _ready() -> void:
	area_entered.connect(_on_body_entered)


func _on_body_entered(body: Area2D) -> void:
	if body is Player:
		area_entered.disconnect(_on_body_entered)
		LevelManager.finish()
