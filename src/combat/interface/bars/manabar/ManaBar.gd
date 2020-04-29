# Can't extend from StatBar (the class_name) because this won't let us export
# the inherited variables from the base class 
extends "res://src/combat/interface/bars/StatBar.gd"
class_name ManaBar

func _connect_value_signals(battler : Battler) -> void:
	battler.connect("mana_changed", self, "_on_value_changed")
	battler.connect("mana_depleted", self, "_on_value_depleted")
	
	self.max_value = battler.max_mana
	self.value = battler.mana
