# Represents a Battler's actual stats: health, strength, etc.
# See the child class GrowthStats.gd for stats growth curves
# and lookup tables
extends Position2D

class_name CharacterStats

signal health_changed(new_health, old_health)
signal health_depleted()
signal mana_changed(new_mana, old_mana)
signal mana_depleted()

var modifiers = {}

var health : int
var mana : int setget set_mana
export var max_health : int = 1 setget set_max_health, _get_max_health
export var max_mana : int = 0 setget set_max_mana, _get_max_mana
export var speed : int = 1 setget ,_get_speed
export(Array, String) var consumables
export(Array, String) var items
export(Array, Resource) var Skills
var is_alive : bool setget ,_is_alive
	
func reset():
	health = self.max_health
	mana = self.max_mana
	
func copy() -> CharacterStats:
	# Perform a more accurate duplication, as normally Resource duplication
	# does not retain any changes, instead duplicating from what's registered
	# in the ResourceLoader
	var copy = duplicate()
	copy.health = health
	copy.mana = mana
	return copy

func take_damage(damage):
	var old_health = health
	health -= damage
	emit_signal("health_changed", health, old_health)
	health = max(0, health)
	if health == 0:
		emit_signal("health_depleted")

func heal(amount : int):
	var old_health = health
	health = min(health + amount, max_health)
	emit_signal("health_changed", health, old_health)

func set_mana(value : int):
	var old_mana = mana
	mana = max(0, value)
	emit_signal("mana_changed", mana, old_mana)
	if mana == 0:
		emit_signal("mana_depleted")
	
func set_max_health(value : int):
	if value == null:
		return
	max_health = max(1, value)

func set_max_mana(value : int):
	if value == null:
		return
	max_mana = max(0, value)

func add_modifier(id : int, modifier):
	modifiers[id] = modifier

func remove_modifier(id : int):
	modifiers.erase(id)
	
func _is_alive() -> bool:
	return health >= 0

func _get_max_health() -> int:
	return max_health

func _get_max_mana() -> int:
	return max_mana
	
func _get_speed() -> int:
	return speed
