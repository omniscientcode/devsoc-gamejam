extends entity

var moveVector = Vector2.RIGHT

func _ready() -> void:
	_connect_processes()
	self.add_to_group("player")

func _physics_process(delta: float) -> void:
	# Update character stats 
	updateStats()
	if enemy_array.size() == 0:
		moveCharacter(delta)
	if !is_on_floor():
		velocity.y += 1000 * delta

# move character function
func moveCharacter(delta):
	animated_sprite_2d.play("move")
	velocity =  velocity.move_toward(Vector2.RIGHT * SPEED, delta * ACCELERATION)
	move_and_slide()
	

# Function that updates player stats
func updateStats():
	SPEED = 100
	HP = 10000
	attack_timer.wait_time = ATTACK_SPEED

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_array.append(body)


func _on_attack_range_body_exited(body: Node2D) -> void:
	if enemy_array.has(body):
		enemy_array.erase(body)
