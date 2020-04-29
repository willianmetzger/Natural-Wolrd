# Represents a playable character to add in the player's party
# Holds the data and nodes for the character's battler, pawn on the map,
# and the character's stats to save the game
extends Node2D

class_name PartyMember

onready var battler : Battler = $Battler
onready var SAVE_KEY : String = "party_member_" + name

func _ready():
	battler.reset()

func get_battler_copy():
	# Returns a copy of the battler to add to the CombatArena
	# at the start of a battle
	return battler.duplicate()


func save(save_game : Resource):
	save_game.data[SAVE_KEY] = {
		'health' : battler.health,
		'mana' : battler.mana,
	}

func load(save_game : Resource):
	var data : Dictionary = save_game.data[SAVE_KEY]
	battler.health = data['health']
	battler.mana = data['mana']
