extends Node

var enemies_defeated = 0
var player_dead = false
var gems = 0
var gacha_stat_increase = 0.0
var skill_level = 0

signal boss_changed

var boss_alive: bool = false:
	set(status):
		boss_alive = status
		emit_signal("boss_changed")

signal coins_changed

var coins: int = 0:
	set(value):
		coins = value
		emit_signal("coins_changed")
