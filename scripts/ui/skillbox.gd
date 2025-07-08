extends Control

@onready var button: Button = $"../Button"
@onready var level_label: Label = $"../Level"
@onready var description: Label = $"../Panel/Description"

var increment = 10
var cost = 15

func _ready() -> void:
	button.pressed.connect(Callable(self, "_on_button_pressed"))
	level_label.text = str(GlobalVariables.skill_level)

func _on_button_pressed() -> void:
	if GlobalVariables.coins < cost:
		pass
	GlobalVariables.skill_level += 1
	level_label.text = str(GlobalVariables.skill_level)
	description.text = "DEALS " + str(GlobalVariables.skill_level * increment) + " (+ 10) DMG"
	GlobalVariables.coins -= cost
