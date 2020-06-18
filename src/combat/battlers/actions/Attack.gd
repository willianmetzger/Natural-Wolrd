extends CombatAction

export(int) var dmg

func execute(targets):
	assert(initialized)
	if actor.party_member and not targets:
		return false

	for target in targets:
		yield(actor.skin.move_to(target), "completed")
		target.take_damage(dmg * actor.damage_mod)
		yield(actor.get_tree().create_timer(1.0), "timeout")
		yield(return_to_start_position(), "completed")
	return true
