extends CanvasLayer

signal recover_health()
signal recover_mana()

onready var partyMembers = [$ItemBar/Label/Chloe, $ItemBar/Label/Ally1, $ItemBar/Label/Ally2]
onready var activeMembers = 1
onready var equipment = [$ItemBar/Label/HeartSeed, $ItemBar/Label/ThornSword, $ItemBar/Label/FloralShield, $ItemBar/Label/GliciniaCrown, $ItemBar/Label/LeafShoes]
onready var potionCountText = [$ItemBar/Label/HealthPotion/Label, $ItemBar/Label/ManaPotion/Label]

func update_health_bar(memberId: int, qntmax: float, qntmin: float):
	partyMembers[memberId].get_node("Lifebarfill").rect_scale.x = -3 * qntmin / qntmax
	
func update_mana_bar(memberId: int, qntmax: float, qntmin: float):
	partyMembers[memberId].get_node("Manabarfill").rect_scale.x = -3 * qntmin / qntmax

func update_health_potions(count: int):
	potionCountText[0].text = "x" + str(count)
	
func update_mana_potions(count: int):
	potionCountText[1].text = "x" + str(count)
	
func addEquip(id : int):
	equipment[id].show()


func _on_HealthPotion_pressed() -> void:
	emit_signal("recover_health")


func _on_ManaPotion_pressed() -> void:
	emit_signal("recover_mana")
