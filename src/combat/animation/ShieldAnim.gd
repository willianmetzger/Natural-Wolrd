extends Sprite

class_name ShieldAnim

export var TWEEN_DURATION : float = 1.5

onready var scaleTween = $ScaleTween
onready var opacityTween = $OpacityTween
#onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#start()

func start() :
	scaleTween.interpolate_property(
		self,
		'scale',
		Vector2(1, 1),
		Vector2(10, 10),
		TWEEN_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT)
	scaleTween.start()
	
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
