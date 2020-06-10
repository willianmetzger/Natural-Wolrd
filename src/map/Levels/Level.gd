# Will initialize enemies 
#	and some game variables as combat scene background 
# Processes in pause mode
extends Node
class_name Level

export(float) var cameraRightLimit = 10000000

var enemy_spawners
var enemy_list = []

func _ready() -> void:
	var playerCamera  = $Player/Camera2D
	playerCamera.limit_right = cameraRightLimit
	enemy_spawners = $EnemySpawners
	if enemy_spawners.get_child_count() > 0:
		for spawner in enemy_spawners.get_children():
			var enemy_inst = spawner.initialize()
			add_child(enemy_inst)
			enemy_list.append(enemy_inst)
			
		enemy_spawners.queue_free()
