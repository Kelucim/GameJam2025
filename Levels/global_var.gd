extends Node

var how_many_to_kill = 100
var current_scene : String

func player_died():
	get_tree().call_deferred("change_scene_to_file", current_scene)
