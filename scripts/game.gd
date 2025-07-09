extends Node2D

@onready var gacha_button: Button = $GachaButton/GachaButtonPress
@onready var quests_button: Button = $QuestsButton/QuestsButtonPress
@onready var skills_button: Button = $SkillsButton/SkillsButtonPress

@onready var skills_tab: Control = $SkillsTab
@onready var quests_tab: Control = $QuestTab

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gacha_button.pressed.connect(Callable(self, "_on_gacha_button_pressed"))
	skills_button.pressed.connect(show_skills)
	quests_button.pressed.connect(show_quests)

func _on_gacha_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gacha.tscn")

func show_skills():
	skills_tab.visible = true
	quests_tab.visible = false

func show_quests():
	skills_tab.visible = false
	quests_tab.visible = true
