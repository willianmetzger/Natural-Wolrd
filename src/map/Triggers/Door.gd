extends Sprite

onready var game = get_node("../../")

var is_open = false
var can_open = false

func _process(delta: float) -> void:
	if can_open :
		if Input.is_action_pressed("ui_accept"):
			is_open = true
			can_open = false
			game.load_level()

func _on_area_entered(area: Area2D) -> void:
	can_open = true

func _on_area_exited(area: Area2D) -> void:
	if can_open:
		can_open = false
