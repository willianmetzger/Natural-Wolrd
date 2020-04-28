extends Button

const game_scene = preload("res://src/main/Game.tscn")

func _on_NewGame_pressed() -> void:
	var game = game_scene.instance()
	get_tree().get_root().add_child(game)
	game.prepare_levels(1)
	game.load_level()
	get_node("../../").queue_free()
