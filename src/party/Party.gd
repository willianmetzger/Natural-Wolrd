# Container for the player's party
# Holds all playable game characters whether the player
# has already unlocked them or not in the game.
# After an encounter, it delegates stats update (experience and health) to each
# active party member
extends Node2D
class_name Party

export var PARTY_SIZE : int = 3

var healthPotions = 0
var manaPotions = 0
var inBattle = false
onready var player
onready var GUI

func connect_signals() -> void:
	GUI.connect("recover_health", self, "use_health_potion")
	GUI.connect("recover_mana", self, "use_mana_potion")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("useHealthPotion"):
		use_health_potion()
	if Input.is_action_just_pressed("useManaPotion"):
		use_mana_potion()

func collect(itemId : int):
	match itemId:
		DropSystem.items.HealthPotion:
			healthPotions += 1
			GUI.update_health_potions(healthPotions)			
		DropSystem.items.ManaPotion:
			manaPotions += 1
			GUI.update_mana_potions(manaPotions)			
		DropSystem.items.HeartSeed:
			GUI.addEquip(itemId-2)
			var current_members = get_active_members()
			for member in current_members:
				member.battler.set_max_health(member.battler._get_max_health() * 1.5)
				member.battler.health = member.battler._get_max_health()
		DropSystem.items.ThornSword:
			GUI.addEquip(itemId-2)
			var current_members = get_active_members()
			for member in current_members:
				member.battler.damage_mod = 1.45
		DropSystem.items.FloralShield:
			GUI.addEquip(itemId-2)
			var current_members = get_active_members()
			for member in current_members:
				member.battler.defense = 0.25
		DropSystem.items.GliciniaCrown:
			GUI.addEquip(itemId-2)
			var current_members = get_active_members()
			for member in current_members:
				member.battler.set_max_mana(member.battler._get_max_mana() * 1.5)
				member.battler.set_mana(member.battler._get_max_mana())
		DropSystem.items.LeafShoes:
			GUI.addEquip(itemId-2)
			player.speedModifier = 1.3
			var current_members = get_active_members()
			for member in current_members:
				member.battler.set_speed(member.battler._get_speed() * 1.3)
				
func updateGUI():
	var current_members = get_active_members()
	var iterator = 0
	for member in current_members:
		GUI.update_health_bar(iterator, member.battler._get_max_health(), member.battler.health)
		GUI.update_mana_bar(iterator, member.battler._get_max_mana(), member.battler.mana)
		iterator += 1
			
func use_health_potion() -> void:
	if healthPotions > 0:
		var current_members = get_active_members()
		var iterator = 0
		
		for member in current_members:
			if member.battler.health != member.battler._get_max_health():
				break
			iterator += 1
			if iterator == current_members.size():
				return
			
		healthPotions -= 1
		GUI.update_health_potions(healthPotions)
		for member in current_members:
			member.battler.heal(member.battler._get_max_health() * 0.5)
			GUI.update_health_bar(iterator, member.battler._get_max_health(), member.battler.health)
			iterator += 1
		
func use_mana_potion() -> void:
	if manaPotions > 0:
		var current_members = get_active_members()
		var iterator = 0
		
		for member in current_members:
			if member.battler.mana != member.battler._get_max_mana():
				break
			iterator += 1
			if iterator == current_members.size():
				return
		
		manaPotions -= 1
		GUI.update_mana_potions(manaPotions)		
		for member in current_members:
			member.battler.mana_heal(member.battler._get_max_mana() * 0.5)
			GUI.update_mana_bar(iterator, member.battler._get_max_mana(), member.battler.mana)
			iterator += 1

func get_active_members():
	# Returns the first unlocked children until the party is filled
	var active = []
	var available = get_unlocked_characters()
	for i in range(min(len(available), PARTY_SIZE)):
		active.append(available[i])
	return active
	
func get_unlocked_characters() -> Array:
	# Returns all the characters that can be active in the party
	var has_unlocked = []
	for member in get_children():
		if member.visible:
			has_unlocked.append(member)
	return has_unlocked
