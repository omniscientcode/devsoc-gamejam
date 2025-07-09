extends entity

var COINS_ON_DEATH = 100

func _ready() -> void:
	_connect_processes()
	CURRENT_HP = MAX_HP
	self.add_to_group("enemy")

func _physics_process(delta: float) -> void: 
	# If player dies remove enemy
	if (GlobalVariables.player_dead == true):
		call_deferred("queue_free")
	if enemy_array.size() == 0:
		moveCharacter(delta)

func moveCharacter(delta):
	animated_sprite_2d.play("move")
	velocity =  velocity.move_toward(Vector2.LEFT * SPEED, delta * ACCELERATION)
	move_and_slide()
	
func death():
	GlobalVariables.boss_alive = false
	GlobalVariables.coins += COINS_ON_DEATH
	animated_sprite_2d.play("death")
	await get_tree().create_timer(0.8).timeout
	call_deferred("queue_free")

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		enemy_array.append(body)

func _on_attack_range_body_exited(body: Node2D) -> void:
	if enemy_array.has(body):
		enemy_array.erase(body)


func _on_death_sound_finished() -> void:
	pass # Replace with function body.
