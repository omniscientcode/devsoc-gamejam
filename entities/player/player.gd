extends entity

func _physics_process(delta: float) -> void:
	# Update character stats 
	updateStats()
	attackCheck()
	if enemy_array.length() == 0:
		attack_timer.stop()
		moveCharacter()

# move character function
func	 moveCharacter():
	animated_sprite_2d.play("move")

# Function that updates player stats
func updateStats():
	attack_timer.wait_time = ATTACK_SPEED


# If enemy enters, add to attack array
func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		enemy_array.append(area)

# If enemy dies, remove from array
func _on_attack_range_area_exited(area: Area2D) -> void:
	if enemy_array.has(area):
		enemy_array.erase(area)
