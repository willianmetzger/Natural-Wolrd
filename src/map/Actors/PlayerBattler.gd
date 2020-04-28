extends Sprite
class_name PlayerBattler

var hp
var max_hp
var hp_bar
var mp
var max_mp
var mp_bar
var speed
var skills
var consumables

func initialize(character_stats):
	hp_bar = hp / max_hp
	mp_bar = mp / max_mp
