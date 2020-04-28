extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP # Variable used to tell move_and_slide func where the floor is #

export var speed: = Vector2(300.0, 1000.0)
export  var gravity: = 4000.0

var _velocity: = Vector2.ZERO
	
