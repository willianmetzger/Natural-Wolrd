# Base entity that represents a character or a monster in combat
# Every battler has an AI node so all characters can work as a monster
# or as a computer-controlled player ally
extends CharacterStats

class_name Battler

signal died(battler)

export var TARGET_OFFSET_DISTANCE : float = 120.0

onready var skin = $Skin
onready var actions = $Actions
onready var bars = $Bars
onready var skills = $Skills
onready var ai = $AI
onready var shieldAnim = $ShieldAnim
onready var missManaAnim = $MissMana

var target_global_position : Vector2

var selected : bool = false setget set_selected
var selectable : bool = false setget set_selectable
var display_name : String

export var party_member = false
export var turn_order_icon : Texture

func _ready() -> void:
	selectable = true
	
func initialize():
	var direction : Vector2 = Vector2(-1.0, 0.0) if party_member else Vector2(1.0, 0.0)
	target_global_position = $TargetAnchor.global_position + direction * TARGET_OFFSET_DISTANCE
	skin.initialize()
	actions.initialize(skills.get_children())
	.connect("health_depleted", self, "_on_health_depleted")

func is_able_to_play() -> bool:
	# Returns true if the battler can perform an action
	return health > 0

func set_selected(value):
	selected = value
	skin.blink = value

func set_selectable(value):
	selectable = value
	if not selectable:
		set_selected(false)

func take_damage(damage):
	.take_damage(damage)
	# prevent playing both stagger and death animation if health <= 0
	if health > 0:
		skin.play_stagger()

func _on_health_depleted():
	selectable = false
	yield(skin.play_death(), "completed")
	emit_signal("died", self)

func appear():
	var offset_direction = 1.0 if party_member else -1.0
	skin.position.x += TARGET_OFFSET_DISTANCE * offset_direction
	skin.appear()

func has_point(point : Vector2):
	return skin.battler_anim.extents.has_point(point)

func end_battle():
	skin.hide()
	for bar in bars.get_children():
		bar.queue_free()
	for action in actions.get_children():
		if action.name != "Attack":
			action.queue_free()
