extends Node2D

@onready var label: RichTextLabel = $Label
@onready var button: Button = $Button

# Pool of ids
var gacha_pool: = [
	{"id": "exchange_desk", "name": "Exchange Desk", "rarity": "SSR", "weight": 5}
]

func pull_item() -> Dictionary:
	var total_weight = 0
	for item in gacha_pool:
		total_weight += item.weight
	
	# get total weight and an integer between 0 - 99
	var result = randi() % total_weight
	var culm = 0
	# For each item, add up their weights. if it exceeds the number generated, then return that item
	for item in gacha_pool:
		culm += item.weight
		if culm > result:
			return item
	return {}

func _on_button_pressed() -> void:
	var item = pull_item()
	label.add_theme_color_override("font_color", get_rarity_color(item.rarity))


func get_rarity_color(rarity: String) -> Color:
	match rarity:
		"C": return Color.GRAY
		"R": return Color.BLUE
		"SR": return Color.PURPLE
		"SSR": return Color.GOLD
		_: return Color.WHITE
