extends CharacterBody3D
class_name enemy

@export var max_health : int = 100
@export var damage : int = 20

var health : int = 1
var player_los_check_position
var player_ghost_los_check_position
var player_hitbox : player_ghost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if player_ghost_los_check_position and player_los_check_position:
		%WeaponRaycast.target_position = player_ghost_los_check_position
		%PlayerWeaponRaycast.target_position = player_los_check_position
	
	if %WeaponRaycast.is_colliding() && %PlayerWeaponRaycast.is_colliding():
		if (%WeaponRaycast.get_collider() is player_ghost and %PlayerWeaponRaycast.get_collider() is player) and %AttackTimer.is_stopped():
			player_hitbox = %WeaponRaycast.get_collider()
			print_debug("see you")
			%AttackTimer.start()
		

func lose_healt(how_much : int):
	health -= how_much
	if health <= 0:
		died()

func died():
	GlobalVar.how_many_to_kill -= 1
	self.queue_free()

func target_position(target, player_ghost_position):
	look_at(Vector3(target.x, position.y, target.z))
	player_ghost_los_check_position = to_local(player_ghost_position)
	player_los_check_position = to_local(target)


func _on_attack_timer_timeout() -> void:
	print_debug("Are ja dead")
	is_still_colliding()

func is_still_colliding():
	if %WeaponRaycast.is_colliding() && %PlayerWeaponRaycast.is_colliding():
		if %WeaponRaycast.get_collider() is player_ghost and %PlayerWeaponRaycast.get_collider() is player:
			player_hitbox.player_lost_health(damage)
		else:
			print_debug("nah")
