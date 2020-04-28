# Responsible for transitions between the main game screens:
# combat, game over, and the map
extends Node

signal combat_started()

const combat_arena_scene = preload("res://src/combat/CombatArena.tscn")
onready var possible_levels = null
onready var transition = $Overlays/TransitionColor
onready var level = null
onready var player
onready var party = $Party as Party
onready var music_player = $MusicPlayer
onready var game_over_interface : = $GameOverInterface
#onready var gui : = $Level/GUI

var transitioning = false
var combat_arena : CombatArena

func prepare_levels(game_stage) -> void:
	possible_levels = ["res://src/map/Levels/Level.tscn"]

func load_level():
	var level_chosen = int(rand_range(0, possible_levels.size() - 1))
	level = load(possible_levels[level_chosen]).instance()
	add_child(level)
	player = $Level/Player
	player.connect("enemies_encountered", self,  "enter_battle")

func enter_battle(formation: Formation):
	# Plays the combat transition animation and initializes the combat scene
	if transitioning:
		return

	#gui.hide()
	music_player.play_battle_theme()

	transitioning = true
	yield(transition.fade_to_color(), "completed")

	remove_child(level)
	combat_arena = combat_arena_scene.instance()
	add_child(combat_arena)
	combat_arena.connect("victory", self, "_on_CombatArena_player_victory")
	combat_arena.connect("game_over", self, "_on_CombatArena_game_over")
	combat_arena.connect("battle_completed", self, "_on_CombatArena_battle_completed", [combat_arena])
	combat_arena.initialize(formation, party.get_active_members())

	yield(transition.fade_from_color(), "completed")
	transitioning = false

	combat_arena.battle_start()
	emit_signal("combat_started")

func _on_CombatArena_battle_completed(arena):
	# At the end of an encounter, fade the screen, remove the combat arena
	# and add the local map back
	#gui.show()
	
	transitioning = true
	yield(transition.fade_to_color(), "completed")
	combat_arena.queue_free()
	
	add_child(level)
	yield(transition.fade_from_color(), "completed")
	transitioning = false
	music_player.stop()

func _on_CombatArena_player_victory():
	music_player.play_victory_fanfare()

func _on_CombatArena_game_over() -> void:
	transitioning = true
	yield(transition.fade_to_color(), "completed")
	game_over_interface.display(GameOverInterface.Reason.PARTY_DEFEATED)
	yield(transition.fade_from_color(), "completed")
	transitioning = false

func _on_GameOverInterface_restart_requested():
	game_over_interface.hide()
	var formation = combat_arena.initial_formation
	combat_arena.queue_free()
	enter_battle(formation)
