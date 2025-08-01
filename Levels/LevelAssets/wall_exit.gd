extends Node3D
class_name wall_exit_script

	
func _play_open_door():
	$AnimationPlayer.play("Door_open")
