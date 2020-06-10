extends Resource

class_name Skill

signal missed(text)

export var name : String = "Skill"
export var description : String = ""
export var icon : Texture = load("res://icon.png")

export var mana_cost : int
export var is_offensive: bool
export var targets : int
export var num_targets : int
export var damage : int
export(float, 0.0, 1.0) var min_damage_reduction : float
export(float, 0.0, 1.0) var max_damage_reduction : float
export(float, 0.0, 1.0) var success_chance : float

func use(actor : Battler, target : Battler):
	#actor.take_damage(10)
	if !is_offensive:
		actor.defense = rand_range(min_damage_reduction, max_damage_reduction)
		actor.defenseTurns = 3
	else:
		target.take_damage(damage)
	pass
