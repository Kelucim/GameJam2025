extends CharacterBody3D
class_name player

const SPEED = 5.0
const JUMP_VELOCITY = 100
const MAX_HEALTH = 10

var mouse_sensitivity = 0.5
var can_dash := true
var rotation_x := 0.0
var rotation_y := 0.0
var health = 1

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	health = MAX_HEALTH
	get_tree().call_group("game_ui","change_health", health)
	change_sensitivity(GlobalVar.mouse_sensitivity)

	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "movee_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if input_dir != Vector2.ZERO and $WalkingAudioStream.playing == false:
		#$PlayerCamera/Pistol.play_walking_animation()
		$WalkingAudioStream.play()
	elif input_dir == Vector2.ZERO:
		#$PlayerCamera/Pistol.stop_walking_animation()
		$WalkingAudioStream.stop()
	
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * mouse_sensitivity * get_process_delta_time()
		rotation_x -= event.relative.y * mouse_sensitivity * get_process_delta_time()
		rotation_x = clamp(rotation_x, deg_to_rad(-90), deg_to_rad(90))

	rotation.y = rotation_y
	%PlayerCamera.rotation.x = rotation_x
	
func _process(_delta: float) -> void:
	pass
	
func player_lost_health(damage_taken):
	health -= damage_taken
	$HitAudio.play()
	get_tree().call_group("game_ui","change_health", health)
	if health <= 0:
		GlobalVar.player_died()
	

func dodged_a_bullete():
	$BulletMissAudio.play()
	
func change_sensitivity(new_sensitivity):
	mouse_sensitivity = new_sensitivity / 10
