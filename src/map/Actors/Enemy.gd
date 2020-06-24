extends "res://src/map/Actors/Actor.gd"

var RightPos = Vector2.ZERO
var LeftPos = Vector2.ZERO
var direction = 1
var limitedPath = true
onready var animator = $enemy

func _ready() -> void:
	set_physics_process(false)
	animator.scale.x *= -direction
	_velocity.x = -speed.x * direction

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if _velocity.x != 0:
		if is_on_wall():
			_velocity.x *= -1
			animator.scale.x *= -1
		_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
		
		if limitedPath:
			if position.x > RightPos.x:
				_velocity.x *= -1
				animator.scale.x *= -1
			elif position.x < LeftPos.x:
				_velocity.x *= -1
				animator.scale.x *= -1
				
		if _velocity.x == 0:
			animator.animation = "idle"
