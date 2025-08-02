extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PauseMenu.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
	
func change_health(new_health):
	if new_health == 10:
		%HealthLabel.text = "IIIIIIIIII"
	elif new_health == 9:
		%HealthLabel.text = "IIIIIIIII"
	elif new_health == 8:
		%HealthLabel.text = "IIIIIIII"
	elif new_health == 7:
		%HealthLabel.text = "IIIIIII"
	elif new_health == 6:
		%HealthLabel.text = "IIIIII"
	elif new_health == 5:
		%HealthLabel.text = "IIIII"
	elif new_health == 4:
		%HealthLabel.text = "IIII"
	elif new_health == 3:
		%HealthLabel.text = "III"
	elif new_health == 2:
		%HealthLabel.text = "II"
	elif new_health == 1:
		%HealthLabel.text = "I"
	elif new_health <= 0:
		%HealthLabel.text = ""
	
	if new_health >= 7:
		%HealthLabel.add_theme_color_override("font_color", Color.GREEN)
	elif new_health < 7 and new_health > 3:
		%HealthLabel.add_theme_color_override("font_color", Color.YELLOW)
	elif new_health <=3:
		%HealthLabel.add_theme_color_override("font_color", Color.RED)


func _on_h_slider_value_changed(value: float) -> void:
	get_tree().call_group("player_group", "change_sensitivity", value)

func change_ammo(new_ammo, max_ammo):
	%AmmoLabel.text = str(new_ammo,"/",max_ammo)
	
	if new_ammo > 3:
		%AmmoLabel.add_theme_color_override("font_color", Color.YELLOW)
	elif new_ammo <=3:
		%AmmoLabel.add_theme_color_override("font_color", Color.RED)


func _on_resume_button_pressed() -> void:
	toggle_pause()

func toggle_pause():
	if get_tree().paused == false:
		get_tree().paused = true
		$PauseMenu.visible = true
		$InGame.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif get_tree().paused == true:
		get_tree().paused = false
		$PauseMenu.visible = false
		$InGame.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
