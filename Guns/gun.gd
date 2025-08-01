extends Node3D

@export var max_ammo : int = 10
@export var is_automatic : bool = false
@export var reload_speed : int = 2
@export var damage : int = 25

@onready var ammo_label = $Control/MarginContainer/AmmoLabel

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
		%ReloadTimer.start()
		print_debug("reloading")
	
	if !reloading:
		if is_automatic:
			if Input.is_action_pressed("attack"):
				shoot()
		else:
			if Input.is_action_just_pressed("attack"):
				shoot()


func shoot():
	ammo = ammo-1
	if %RayCast.is_colliding():
		if %RayCast.get_collider() is hit_box:
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
	ammo_label.text = str(ammo,"/",max_ammo)
