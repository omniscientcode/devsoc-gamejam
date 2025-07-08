extends Area2D

signal hurt(DAMAGE) # sends out a signal "hurt" when damaged

func damage(attack):
	emit_signal("hurt", attack)
