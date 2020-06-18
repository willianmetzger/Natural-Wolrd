extends Sprite

var is_open = false
var can_open = false

var player

func _process(delta: float) -> void:
	if can_open :
		if Input.is_action_pressed("ui_accept"):
			is_open = true
			can_open = false
			player.collect(roll_drop())
			$Light2D.queue_free()
			$ButtonUI.hide()

func _on_area_entered(area: Area2D) -> void:
	if !is_open:
		can_open = true
		$ButtonUI.show()
		player = area.owner
	print(can_open)

func _on_area_exited(area: Area2D) -> void:
	if can_open:
		can_open = false
		$ButtonUI.hide()
	print(can_open)

func roll_drop() -> int:
	var rarity = int(rand_range(0, 100))
	if DropSystem.drop_list.size() > 2:		
		if rarity <= 80:
			if rarity <= 80/2:
				return DropSystem.items.HealthPotion
			else:
				return DropSystem.items.ManaPotion
		else :
			var pos = int(rand_range(2, DropSystem.drop_list.size()))
			var drop = DropSystem.drop_list[pos]
			DropSystem.remove_item(pos)
			return drop
	else:
		if rarity <= 50:
				return DropSystem.items.HealthPotion
		else:
			return DropSystem.items.ManaPotion
