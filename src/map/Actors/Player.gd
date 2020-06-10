class_name Player
extends Actor

enum facing{
	Left,
	Right
}

export var stomp_impulse = 1000.0
var _camera_current_limits: Vector3
var sprDir = facing.Left

signal enemies_encountered(formation)

func start_encounter(formation) -> void:
	emit_signal("enemies_encountered", formation.formation.instance())

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	start_encounter(body.get_node("./Formation"))
	body.get_node(".").queue_free()

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	if Input.is_action_just_pressed("move_left"):
		if sprDir == facing.Right:
			scale.x *= -1
		sprDir = facing.Left
	elif Input.is_action_just_pressed("move_right"):
		if sprDir == facing.Left:
			scale.x *= -1
		sprDir = facing.Right

	""" Return a direction based on player's inputs """
func get_direction() -> Vector2:	# Right = 1.0 Left = -1.0 #
	return Vector2(  
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
			-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
	
	"""
	Return velocity based on player's direction
	This structure is used to avoid modifing directly any character's property inside the function
	"""
func calculate_move_velocity( 
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
		
		# Calculate X #
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	
		# Calculate Y #
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.y  = -impulse
	return new_velocity


"""
Set new limits to the camera
"""
func set_camera_limits(left: float, right: float, top: float) -> void:
	var player_camera: Camera2D = get_node("Camera2D")
	
	if left != -1:
		player_camera.limit_left = left
	if right != -1:
		player_camera.limit_right = right
