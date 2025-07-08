extends Node2D

@export var spawns: Array[Spawn_info] = []


func _on_timer_timeout() -> void:
	var enemy_spawns = spawns
	for i in enemy_spawns: # For each enemy
		if i.SPAWN_DELAY_COUNTER < i.SPAWN_DELAY: # Spawn enemies with a delay 
			i.SPAWN_DELAY_COUNTER += 1
		else:
			if (GlobalVariables.player_dead != true):
				spawn_enemy(i)
			
func spawn_enemy(i):
	i.SPAWN_DELAY_COUNTER = 0 # reset delay
	var enemy = i.enemy.instantiate()
	enemy.position = global_position # spawn at node position
	get_parent().add_child(enemy)
