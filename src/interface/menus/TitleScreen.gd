extends Control

export(Array, NodePath) var TitleButtons
export(Array, NodePath) var TitleArrowPos

onready var ArrowPosition = 0
onready var Arrow = $Arrow

func _process(delta: float) -> void:
	if !$Panel.visible:
		if Input.is_action_just_pressed("ui_accept"):
			get_node(TitleButtons[ArrowPosition]).execute()
			
		if Input.is_action_just_pressed("ui_up"):
			if ArrowPosition > 0:
				ArrowPosition -= 1
			else:
				ArrowPosition = 2
				
			Arrow.rect_position = get_node(TitleArrowPos[ArrowPosition]).position
			
		if Input.is_action_just_pressed("ui_down"):
			if ArrowPosition < 2:
				ArrowPosition += 1
			else:
				ArrowPosition = 0
				
			Arrow.rect_position = get_node(TitleArrowPos[ArrowPosition]).position

func _on_NewGame_mouse_entered() -> void:
	ArrowPosition = 0
	Arrow.rect_position = get_node(TitleArrowPos[ArrowPosition]).position


func _on_Credits_mouse_entered() -> void:
	ArrowPosition = 1
	Arrow.rect_position = get_node(TitleArrowPos[ArrowPosition]).position


func _on_Quit_mouse_entered() -> void:
	ArrowPosition = 2
	Arrow.rect_position = get_node(TitleArrowPos[ArrowPosition]).position
