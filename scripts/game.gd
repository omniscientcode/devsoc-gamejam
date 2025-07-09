extends Node2D

@onready var gacha_button: Button = $GachaButton/GachaButtonPress
@onready var unsw_background_png: Sprite2D = $"Unsw-background_png"

const BOSS_BG = preload("res://assets/images/bg/boss_battle.png")
const DEFAULT_BG = preload("res://assets/images/bg/unsw-background.png.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.connect("boss_changed", Callable(self, "_bg_change"))
	gacha_button.pressed.connect(Callable(self, "_on_gacha_button_pressed"))
	
func _on_gacha_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gacha.tscn")
	
func _bg_change() -> void:
	if GlobalVariables.boss_alive:
		unsw_background_png.texture = BOSS_BG
	if GlobalVariables.boss_alive == false:
		await get_tree().create_timer(0.8).timeout
		unsw_background_png.texture = DEFAULT_BG
