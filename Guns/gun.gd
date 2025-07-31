extends Node3D

@export var max_ammo : int = 10


var ammo : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ammo = max_ammo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
