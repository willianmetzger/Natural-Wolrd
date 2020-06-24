extends Button

export(NodePath) var labelPath
var is_enabled = false

func _process(delta: float) -> void:
	if is_enabled:
		if Input.is_action_just_pressed("ui_cancel"):
			get_node(labelPath).hide()
			is_enabled = false

func _on_Credits_pressed() -> void:
	execute()
	
func execute():
	get_node(labelPath).show()
	is_enabled = true
