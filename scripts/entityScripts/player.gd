extends entity

var moveVector = Vector2.RIGHT
@onready var respawn_timer: Timer = %respawnTimer

func _ready() -> void:
	self.visible = true
	_connect_processes()
	MAX_HP = 1000.0
	CURRENT_HP = MAX_HP
	self.add_to_group("player")

func _physics_process(delta: float) -> void:
	# Update character stats 
	updateStats()
	#if enemy_array.size() == 0:
		#moveCharacter(delta)
	if !is_on_floor():
		velocity.y += 1000 * delta

# move character function
#func moveCharacter(delta):
	#animated_sprite_2d.play("move")
	#velocity =  velocity.move_toward(Vector2.RIGHT * SPEED, delta * ACCELERATION)
	#move_and_slide()
	

# Function that updates player stats
func updateStats():
	attack_timer.wait_time = ATTACK_SPEED

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_array.append(body)


func _on_attack_range_body_exited(body: Node2D) -> void:
	if enemy_array.has(body):
		enemy_array.erase(body)

func death():
	animated_sprite_2d.play("death")
	GlobalVariables.player_dead = true
	set_physics_process(false)
	self.visible = false
	respawn_timer.start()


func _on_respawn_timer_timeout() -> void:
	GlobalVariables.player_dead = false
	self.visible = true
	set_physics_process(true)
	global_position = Vector2(0, -280)
	CURRENT_HP = MAX_HP
