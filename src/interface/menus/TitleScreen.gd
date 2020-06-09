extends Control

export(NodePath) var TitleButtons
export(Vector2) var TitleArrowPos

export(NodePath) var OptionsButtons
export(Vector2) var OptionsArrowPos

onready var menuId = 0
onready var ArrowPosition = 0
onready var Arrow = $Arrow

#func _process(delta: float) -> void:
#	match menuId:
#		0:
#			Arrow.position = TitleArrowPos[ArrowPosition]
#		1:
#			Arrow.position = OptionsArrowPos[ArrowPosition]

func _on_NewGame_mouse_entered() -> void:
	ArrowPosition = 0


func _on_Options_mouse_entered() -> void:
	ArrowPosition = 1


func _on_Quit_mouse_entered() -> void:
	ArrowPosition = 2
