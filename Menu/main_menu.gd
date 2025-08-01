extends Node3D

@onready var master_audio_bus = AudioServer.get_bus_index("Master")


func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Levels/level_1.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(master_audio_bus, value)
