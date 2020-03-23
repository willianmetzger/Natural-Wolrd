extends Area2D

export var camera_new_limit: Vector3 = Vector3(-1.0, -1.0, -1.0)


func _on_body_entered(body: Node) -> void:
	var player: Player = body.get_node(".")
	player.set_camera_limits(
		camera_new_limit.x, # Left
		camera_new_limit.y, # Right
		camera_new_limit.z  # Top
	)


func _on_body_exited(body: Node) -> void:
	print("okay")
