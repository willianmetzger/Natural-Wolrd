extends Node2D

enum items{
	HealthPotion,
	ManaPotion,
	HeartSeed,
	ThornSword,
	FloralShield,
	GliciniaCrown,
	LeafShoes
}

var drop_list = [items.HealthPotion, items.ManaPotion, items.FloralShield, items.GliciniaCrown, items.HeartSeed, items.LeafShoes, items.ThornSword]
			
func remove_item(pos : int):
	drop_list.remove(pos)

func reset():
	drop_list = [items.HealthPotion, items.ManaPotion, items.FloralShield, items.GliciniaCrown, items.HeartSeed, items.LeafShoes, items.ThornSword]
