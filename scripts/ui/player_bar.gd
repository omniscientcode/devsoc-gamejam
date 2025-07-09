extends Control

@onready var coins_amount: Label = $Coins/CoinsAmount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.connect("coins_changed", Callable(self, "_update_coins"))
	coins_amount.text = str(GlobalVariables.coins)

func _update_coins() -> void:
	await get_tree().create_timer(0.8).timeout
	coins_amount.text = str(GlobalVariables.coins)
