extends Node

@export var number_of_enemies : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVar.how_many_to_kill = number_of_enemies
	
func _process(delta: float) -> void:
	print_debug(%Player.global_transform.origin)
	get_tree().call_group("enemies", "target_position", %Player.global_transform.origin)
