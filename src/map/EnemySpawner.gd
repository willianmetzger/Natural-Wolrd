extends Node2D
class_name EnemySpawner

export(Array, PackedScene) var enemy_list

var enemy_inst

func initialize():
	#Get random enemy from the list to spawn
	var chosen_enemy = enemy_list[rand_range(0, enemy_list.size() - 1)]
	enemy_inst = chosen_enemy.instance()
	enemy_inst.position = position
	return enemy_inst
