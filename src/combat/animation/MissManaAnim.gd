extends Sprite

class_name MissManaAnim

export var TWEEN_DURATION : float = 1.5

onready var moveTween = $MoveTween
onready var opacityTween = $OpacityTween
#onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#start()

func start() :
	moveTween.interpolate_property(
		self,
		'position',
		Vector2(0, 0),
		Vector2(0, -100),
		TWEEN_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT)
	moveTween.start()
	
	opacityTween.interpolate_property(
		self,
		'modulate:a',
		1,
		0,
		TWEEN_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT)
	opacityTween.start()
	
	#tween.interpolate_callback(self, 2, "start")
	#tween.start()
