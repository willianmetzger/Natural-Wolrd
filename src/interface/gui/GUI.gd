extends CanvasLayer
class_name GUI

onready var tween : = $Tween
onready var container : = $Container
onready var animation_player : = $Container/AnimationPlayer


func _wiggle_element(element) -> void:
	var wiggles = 6
	var offset = Vector2(15, 0)
	var last_position = element.rect_position
	for i in range(wiggles):
		var direction = 1 if i % 2 == 0 else - 1
		tween.interpolate_property(element,
			"rect_position",
			last_position,
			element.rect_position + offset * direction,
			0.05,
			Tween.TRANS_BOUNCE, 
			Tween.EASE_IN,
			i * 0.05)
		last_position = element.rect_position + offset * direction
	tween.interpolate_property(element,
			"rect_position",
			last_position,
			element.rect_position,
			0.05,
			Tween.TRANS_BOUNCE, 
			Tween.EASE_IN,
			wiggles * 0.05)
	tween.start()

func hide() -> void:
	container.hide()

func show() -> void:
	container.show()
