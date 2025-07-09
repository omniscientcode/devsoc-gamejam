extends Node2D

@onready var gacha_button: Button = $GachaButton/GachaButtonPress

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gacha_button.pressed.connect(Callable(self, "_on_gacha_button_pressed"))
	
func _on_gacha_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gacha.tscn")
