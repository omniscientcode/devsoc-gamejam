extends CharacterBody2D

class_name entity

@export var CURRENT_HP = 100.0
@export var MAX_HP = 100.0 
@export var SPEED = 10.0
@export var ACCELERATION = 100

@export var ATTACK = 20.0
@export var DAMAGE_RESISTANCE = 0.0
@export var CRIT_CHANCE = 0.05
@export var ATTACK_SPEED = 1.0

const FRICTION = 100

@onready var attack_range: Area2D = %attackRange
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var attack_timer: Timer = %AttackTimer
@onready var collision_detection: CollisionShape2D = $CollisionDetection

var enemy_array = [];

func _ready() -> void:
	_connect_processes()

func _connect_processes() -> void:
	if not attack_timer.is_connected("timeout", Callable(self, "_on_attack_timer_timeout")):
		attack_timer.connect("timeout", Callable(self, "_on_attack_timer_timeout"))
	if not attack_range.is_connected("body_entered", Callable(self, "_on_attack_range_body_entered")):
		attack_range.connect("body_entered", Callable(self, "_on_attack_range_body_entered"))
	if not attack_range.is_connected("body_exited", Callable(self, "_on_attack_range_body_exited")):
		attack_range.connect("body_exited", Callable(self, "_on_attack_range_body_exited"))


func _physics_process(_delta: float) -> void: 
	pass

# attack all enemies
func attackEnemies():
	for enemy in enemy_array:
		enemy.damage(ATTACK)

func damage(damageTaken):
	var actualDamageTaken = max(damageTaken * (1 - DAMAGE_RESISTANCE), 0.0)
	CURRENT_HP -= actualDamageTaken
	if CURRENT_HP <= 0:
		death()

func death():
	GlobalVariables.enemies_defeated += 1
	animated_sprite_2d.play("death")
	call_deferred("queue_free")

# On attack timer timeout, attack enemies
func _on_attack_timer_timeout() -> void:
	if (enemy_array.size() > 0):
		animated_sprite_2d.play("attack")
		attackEnemies()
	attack_timer.start()

# If enemy enters, add to attack array
func _on_attack_range_body_entered(body: Node2D) -> void:
	pass

# If enemy dies, remove from array
func _on_attack_range_body_exited(body: Node2D) -> void:
	pass
