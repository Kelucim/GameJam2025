extends Node3D

@export var max_ammo : int = 10
@export var is_automatic : bool = false
@export var reload_speed : float = 2
@export var damage : int = 25

@onready var gunshoot_audio = $GunShotAudioStream
@onready var reload_audio = $ReloadAudioStream
@onready var blood_particles : PackedScene = preload("res://Player/blood_particles.tscn")
@onready var hand_animations : player_animation_node = $PlayerViewmodel

var can_shoot := true
var ammo : int
var reloading : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ammo = max_ammo
	%ReloadTimer.wait_time = reload_speed
	update_ammo_count()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (ammo == 0 or Input.is_action_just_pressed("reload")) and !reloading:
		reloading = true
		hand_animations.play_reload()
		reload_audio.play()
		%ReloadTimer.start()
		print_debug("reloading")
	
	if !reloading and can_shoot:
		if is_automatic:
			if Input.is_action_pressed("attack"):
				shoot()
		else:
			if Input.is_action_just_pressed("attack"):
				shoot()
	

func shoot():
	can_shoot = false
	%CanShootTimer.start()
	hand_animations.play_shoot()
	gunshoot_audio.play()
	ammo = ammo-1
	if %RayCast.is_colliding():
		if %RayCast.get_collider() is hit_box:
			var blood_instance : CPUParticles3D = blood_particles.instantiate()
			blood_instance.transform.origin = %RayCast.get_collision_point()
			get_parent().get_parent().add_sibling(blood_instance)
			var target : hit_box= %RayCast.get_collider()
			target.got_hit(damage)
	print_debug("shoot")
	update_ammo_count()


func _on_reload_timer_timeout() -> void:
	reloading = false
	ammo = max_ammo
	print_debug("reloaded")
	update_ammo_count()

func update_ammo_count():
	get_tree().call_group("game_ui","change_ammo", ammo, max_ammo)
	
func play_walking_animation():
	hand_animations.play_walking()

func stop_walking_animation():
	pass
	hand_animations.stop_walking()


func _on_can_shoot_timer_timeout() -> void:
	can_shoot = true
