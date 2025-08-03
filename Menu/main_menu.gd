extends Node3D

@onready var master_audio_bus = AudioServer.get_bus_index("Master")

func _ready() -> void:
	AudioServer.set_bus_volume_db(master_audio_bus, %VolimeSlider.value)
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	%VolimeSlider.value = GlobalVar.game_volume

func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Levels/level_1.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	GlobalVar.game_volume = value
	AudioServer.set_bus_volume_db(master_audio_bus, value)
