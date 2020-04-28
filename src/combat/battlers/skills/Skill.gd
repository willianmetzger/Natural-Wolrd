extends Resource

class_name Skill

signal missed(text)

export var name : String = "Skill"
export var description : String = ""
export var icon : Texture = load("res://icon.png")

export var mana_cost : int
export var is_offensive: bool
export var targets : int
export(float, 0.0, 1.0) var success_chance : float

func use(target):
	pass
