extends Node3D
class_name player_animation_node

func play_shoot():
	$AnimationPlayer.play("Shoot")

func play_reload():
	$AnimationPlayer.play("Reload")
