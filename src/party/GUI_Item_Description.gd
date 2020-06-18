extends TextureRect

export(String, MULTILINE) var description

onready var textDescription = get_parent().get_node("ItemText")

func _on_mouse_entered() -> void:
	textDescription.show()
	textDescription.text = description


func _on_mouse_exited() -> void:
	textDescription.hide()
