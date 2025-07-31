extends Node

@export var number_of_enemies : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVar.how_many_to_kill = number_of_enemies
