extends Node2D

class_name MissManaSkinAnimation

onready var anim = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start() :
	anim.start()
