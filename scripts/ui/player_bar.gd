extends Control

@onready var coins_amount: Label = $Coins/CoinsAmount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.coins = 100;
	coins_amount.text = str(GlobalVariables.coins)

func _update_coins() -> void:
	coins_amount.text = str(GlobalVariables.coins)
