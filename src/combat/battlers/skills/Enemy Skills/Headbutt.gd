extends Skill

export(int) var damage

func use(target):
	target.take_damage(damage)
