extends CanvasLayer
class_name GameOverInterface

onready var ArrowPosition = 0
onready var Arrow = $Panel/Arrow

onready var panel : = $Panel as Panel
onready var message_label : = $Panel/VBoxContainer/Message as Label
onready var try_again_button : = $Panel/VBoxContainer/Options/ReturnToTitle as Button
onready var options : = $Panel/VBoxContainer/Options

var buttons = []
var selected_button_index : = 0

func _ready() -> void:
	buttons = options.get_children()
	DropSystem.reset()
	Arrow.rect_position.y = options.rect_position.y + options.get_child(ArrowPosition).rect_position.y + 25
	Arrow.rect_position.x = options.get_child(ArrowPosition).rect_position.x - 64

func _unhandled_input(event) -> void:
	if not panel.visible:
		return	
	
	if Input.is_action_just_pressed("ui_accept"):
		match ArrowPosition:
			0:
				return_to_title()
			1:
				quit_game()
		
	if Input.is_action_just_pressed("ui_up"):
			if ArrowPosition > 0:
				ArrowPosition -= 1
			else:
				ArrowPosition = 1
				
			Arrow.rect_position.y = options.rect_position.y + options.get_child(ArrowPosition).rect_position.y + 25
			Arrow.rect_position.x = options.get_child(ArrowPosition).rect_position.x - 64
			
	if Input.is_action_just_pressed("ui_down"):
		if ArrowPosition < 1:
			ArrowPosition += 1
		else:
			ArrowPosition = 0
			
		Arrow.rect_position.y = options.rect_position.y + options.get_child(ArrowPosition).rect_position.y + 25
		Arrow.rect_position.x = options.get_child(ArrowPosition).rect_position.x - 64

func _on_Exit_pressed() -> void:
	quit_game()

func _on_ReturnToTitle_pressed():
	return_to_title()
	
func return_to_title():
	var titleScreen = load("res://src/interface/menus/TitleScreen.tscn").instance()
	get_tree().root.add_child(titleScreen)
	queue_free()

func quit_game():
	get_tree().quit()

func _on_ReturnToTitle_mouse_entered() -> void:
	ArrowPosition = 0
	Arrow.rect_position.y = options.rect_position.y + options.get_child(ArrowPosition).rect_position.y + 25
	Arrow.rect_position.x = options.get_child(ArrowPosition).rect_position.x - 64


func _on_Exit_mouse_entered() -> void:
	ArrowPosition = 1
	Arrow.rect_position.y = options.rect_position.y + options.get_child(ArrowPosition).rect_position.y + 25
	Arrow.rect_position.x = options.get_child(ArrowPosition).rect_position.x - 64
