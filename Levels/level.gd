extends Node

@export var number_of_enemies : int
@export var player_node : player
@export var player_ghost_node : player_ghost
@export var current_level : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVar.current_scene = current_level
	GlobalVar.how_many_to_kill = number_of_enemies
	
func _process(delta: float) -> void:
	if player_ghost_node:
		player_ghost_node.follow_player(player_node.global_position)
	get_tree().call_group("enemies", "target_position", player_node.global_position, player_ghost_node.global_position)
