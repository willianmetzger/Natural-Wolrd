# Can't extend from StatBar (the class_name) because this won't let us export
# the inherited variables from the base class 
extends "res://src/combat/interface/bars/StatBar.gd"
class_name LifeBar

func _connect_value_signals(battler : Battler) -> void:
	battler.connect("health_changed", self, "_on_value_changed")
	battler.connect("health_depleted", self, "_on_value_depleted")
	
	self.max_value = battler.max_health
	self.value = battler.health
