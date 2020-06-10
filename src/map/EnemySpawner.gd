extends Node2D
class_name EnemySpawner

enum Direction{
	Left = 1,
	Right = -1
}
	

export(Array, PackedScene) var enemy_list
export(bool) var limitedPath 
export(Direction) var direction
export(float) var SpeedMultiplier = 1

var enemy_inst

func initialize():
	#Get random enemy from the list to spawn
	var chosen_enemy = enemy_list[rand_range(0, enemy_list.size() - 1)]
	enemy_inst = chosen_enemy.instance()
	enemy_inst.position = position
	enemy_inst.limitedPath = limitedPath
	enemy_inst.direction = direction
	enemy_inst.speed.x *= SpeedMultiplier
	if limitedPath:
		enemy_inst.RightPos = $RightPos.position + position
		enemy_inst.LeftPos = $LeftPos.position + position
		
	return enemy_inst
