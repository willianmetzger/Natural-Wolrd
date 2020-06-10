extends Sprite

var drop_list
var is_open = false
var can_open = false

func _process(delta: float) -> void:
	if can_open :
		if Input.is_action_pressed("ui_accept"):
			is_open = true
			can_open = false
			roll_drop()

func _on_area_entered(area: Area2D) -> void:
	if !is_open:
		can_open = true
	print(can_open)

func _on_area_exited(area: Area2D) -> void:
	if can_open:
		can_open = false
	print(can_open)

func roll_drop() :
	var rarity = int(rand_range(0, 100))
	if rarity <= 50:
		print("common item")
	elif rarity <= 85:
		print("uncommon item")
	elif rarity <= 95:
		print("rare item")
	else :
		print("legendary item")
