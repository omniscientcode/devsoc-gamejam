extends Node2D

@export var spawns: Array[Spawn_info] = []
@export var bosses: Array[Spawn_info] = []
@onready var boss_button: Button = $"Boss Summon/BossButton"

var spawn_enabled := true

func _ready() -> void:
	GlobalVariables.connect("boss_changed", Callable(self, "_update_boss"))
	boss_button.pressed.connect(Callable(self, "_on_button_pressed"))

func _on_timer_timeout() -> void:
	if not spawn_enabled:
		return 
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

func _on_button_pressed() -> void:
	GlobalVariables.boss_alive = true
	var bosses = bosses
	for i in bosses: # For each enemy
		if (GlobalVariables.player_dead != true):
			spawn_enemy(i)
			
func _update_boss() -> void:
	if GlobalVariables.boss_alive:
		spawn_enabled = false
	if GlobalVariables.boss_alive == false:
		spawn_enabled = true;
