extends Node3D

@export var next_scene : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%LoadArea.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GlobalVar.how_many_to_kill == 0 and %LoadArea.monitoring != true:
		$WallExit._play_open_door()
		%LoadArea.monitoring = true


func _on_load_area_body_entered(_body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_file", next_scene)
