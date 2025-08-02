extends Node3D
class_name player_animation_node

func play_shoot():
	$AnimationPlayer.play("Shoot")

func play_reload():
	$AnimationPlayer.play("Reload")

func play_walking():
	$AnimationPlayer.play("Walking")

func stop_walking():
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.pause()
