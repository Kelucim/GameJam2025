extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 100

var mouse_sensitivity = 0.5
var can_dash := true
var rotation_x := 0.0
var rotation_y := 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "movee_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_just_pressed("dash") and can_dash:
		can_dash = false
		%DashTimer.start()
		velocity.x = direction.x * JUMP_VELOCITY
		velocity.z = direction.z * JUMP_VELOCITY
		
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * mouse_sensitivity * get_process_delta_time()
		rotation_x -= event.relative.y * mouse_sensitivity * get_process_delta_time()
		rotation_x = clamp(rotation_x, deg_to_rad(-90), deg_to_rad(90))

	rotation.y = rotation_y
	%PlayerCamera.rotation.x = rotation_x
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_text_clear_carets_and_selection"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_dash_timer_timeout() -> void:
	can_dash = true
