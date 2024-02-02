extends Area3D

@export_file("*.tscn") var next_scene

# when the player enters the collider
# load the next_scene scene
func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file(next_scene)
