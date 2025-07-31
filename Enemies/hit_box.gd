extends Area3D
class_name hit_box

@export var is_crit : bool = false


func got_hit(damage : int):
	if get_parent() is enemy:
		var i : enemy = get_parent()
		if is_crit == true:
			i.lose_healt(damage*2)
		else:
			i.lose_healt(damage)
