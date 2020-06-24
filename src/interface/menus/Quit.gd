extends Button

func _on_Quit_pressed() -> void:
	execute()

func execute():
	get_tree().quit()
