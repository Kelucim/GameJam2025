extends Area3D
class_name hit_box

@export var is_crit : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func got_hit(damage : int):
	if get_parent() is enemy:
		var i : enemy = get_parent()
		if is_crit == true:
			i.lose_healt(damage*2)
		else:
			i.lose_healt(damage)
