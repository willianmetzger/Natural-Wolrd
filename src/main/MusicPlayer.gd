extends AudioStreamPlayer

const battle_theme = preload("res://assets/audio/background/battle_1.ogg")
const victory_fanfare = preload("res://assets/audio/bgm/victory_fanfare.ogg")
const bg_1 = preload("res://assets/audio/background/fundo_bg_motores_3.ogg")
const bg_menu = preload("res://assets/audio/background/fundo_bg_motores_1.ogg")

func play_battle_theme():
	stream = battle_theme
	play()

func play_victory_fanfare():
	stream = victory_fanfare
	play()
	
func play_bg_menu():
	stream = bg_menu
	play()

func play_bg_1():
	stream = bg_1
	play()
