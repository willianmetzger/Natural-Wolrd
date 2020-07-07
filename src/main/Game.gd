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
onready var GUI = $GUI
onready var music_player = $MusicPlayer
onready var game_over_interface = "res://src/interface/game_over/GameOverInterface.tscn"
onready var game_stage = 1
onready var current_level = 0

var transitioning = false
var combat_arena : CombatArena

func prepare_levels() -> void:
	if game_stage == 1:
		possible_levels = ["res://src/map/Levels/Level_1.tscn", "res://src/map/Levels/Level_2.tscn", "res://src/map/Levels/Level_3.tscn", "res://src/map/Levels/Level_4.tscn", "res://src/map/Levels/Level_5.tscn"]
	elif game_stage == 2:
		possible_levels = ["res://src/map/Levels/Level_1.tscn", "res://src/map/Levels/Level_2.tscn", "res://src/map/Levels/Level_3.tscn", "res://src/map/Levels/Level_4.tscn", "res://src/map/Levels/Level_5.tscn"]
	else :
		possible_levels = ["res://src/map/Levels/Level_1.tscn", "res://src/map/Levels/Level_2.tscn", "res://src/map/Levels/Level_3.tscn", "res://src/map/Levels/Level_4.tscn", "res://src/map/Levels/Level_5.tscn"] 

func load_level():
	if	current_level == 3:
		remove_child(level)
		level = load("res://src/map/Levels/Rest_Level.tscn").instance()
		add_child(level)
		player = $Level/Player
		player.party = party
		party.player = player
		party.GUI = GUI
		party.connect_signals()
		player.connect("enemies_encountered", self,  "enter_battle")	
		
	elif current_level == 5:
		remove_child(level)
		level = load("res://src/map/Levels/Boss_Level.tscn").instance()
		add_child(level)
		player = $Level/Player
		player.party = party
		party.player = player
		party.GUI = GUI
		party.connect_signals()
		player.connect("enemies_encountered", self,  "enter_battle")
		
	else :
		remove_child(level)
		var level_chosen = rand_range(0, possible_levels.size()) as int
		level = load(possible_levels[level_chosen]).instance()
		add_child(level)
		possible_levels.erase(possible_levels[level_chosen])
		player = $Level/Player
		player.party = party
		party.player = player
		party.GUI = GUI
		party.connect_signals()
		player.connect("enemies_encountered", self,  "enter_battle")
		
	current_level += 1
	
func load_level_byId(id):
	level = load(possible_levels[id]).instance()
	add_child(level)
	possible_levels.erase(possible_levels[id])
	player = $Level/Player
	player.party = party
	party.player = player
	party.GUI = GUI
	party.connect_signals()
	player.connect("enemies_encountered", self,  "enter_battle")
	current_level += 1

func enter_battle(formation: Formation):
	# Plays the combat transition animation and initializes the combat scene
	if transitioning:
		return

	music_player.play_battle_theme()

	transitioning = true
	yield(transition.fade_to_color(), "completed")

	party.inBattle = true
	remove_child(GUI)
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
	
	transitioning = true
	yield(transition.fade_to_color(), "completed")
	combat_arena.queue_free()
	
	party.inBattle = false
	add_child(level)
	add_child(GUI)
	party.updateGUI()
	party.connect_signals()
	yield(transition.fade_from_color(), "completed")
	transitioning = false
	music_player.stop()
	music_player.play_bg_1()

func _on_CombatArena_player_victory():
	music_player.play_victory_fanfare()

func _on_CombatArena_game_over() -> void:
	transitioning = true
	yield(transition.fade_to_color(), "completed")
	game_over_interface = load(game_over_interface).instance()
	get_tree().root.add_child(game_over_interface)
	queue_free()
	yield(transition.fade_from_color(), "completed")
	transitioning = false
