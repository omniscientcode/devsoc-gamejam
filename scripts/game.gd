extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$QuestMenuButton.pressed.connect(_on_quest_button_pressed)
	$QuestMenuPage.visible = false
	pass # Replace with function body.

func _on_quest_button_pressed() -> void:
	$QuestMenuPage.visible = not $QuestMenuPage.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
