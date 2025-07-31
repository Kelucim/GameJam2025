extends Node3D
class_name enemy

@export var max_health : int = 100
var health : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func lose_healt(how_much : int):
	health -= how_much
	if health <= 0:
		died()

func died():
	GlobalVar.how_many_to_kill -= 1
	self.queue_free()
