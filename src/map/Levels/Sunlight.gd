extends Area2D

var in_sunlight = false
var party

func _process(delta: float) -> void:
	if in_sunlight:
		for member in party.get_active_members():
			member.battler.heal(1)
			member.battler.mana_heal(1)
		party.updateGUI()

func _on_Area2D_area_entered(area: Area2D) -> void:
	in_sunlight = true
	party = area.owner.party


func _on_Area2D_area_exited(area: Area2D) -> void:
	in_sunlight = false
