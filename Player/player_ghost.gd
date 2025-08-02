extends CharacterBody3D
class_name player_ghost

@export var default_speed : int = 3

var speed

func _ready() -> void:
	speed = default_speed

func _physics_process(_delta: float) -> void:
	move_and_slide()

func follow_player(player_position: Vector3):
	var distance_from_player = player_position.distance_to(global_position)
	
	if distance_from_player > 1:
		speed = 6
	else:
		speed = 3
	
	var direction = player_position - global_position
	var new_velovity = direction.normalized() * speed
	
	velocity = new_velovity
