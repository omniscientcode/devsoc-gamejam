extends Panel

@onready var button: Button = $"../Button"
@onready var progress_label: Label = $"../Panel/Description"
@onready var progress_panel: Panel = $"../Panel"
var 	quest_done = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(Callable(self, "_on_button_pressed"))


func _on_button_pressed() -> void:
	if not quest_done:
		progress_label.text = "1/1"
		progress_panel.modulate = Color.GREEN
		GlobalVariables.coins += 100
		quest_done = true;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
