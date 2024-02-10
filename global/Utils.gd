extends Node

func get_player() -> Player:
    return get_tree().get_nodes_in_group("Player")[0]