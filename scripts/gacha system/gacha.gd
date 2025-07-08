extends Node2D

@onready var color_rect: ColorRect = $ColorRect
@onready var button: Button = $Button
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var label: Label = $VBoxContainer/Label
@onready var screen_image: AnimatedSprite2D = $screenImage
@onready var curr_anim = ""
@onready var rollsound: AudioStreamPlayer = $rollsound
@onready var finish_roll: AudioStreamPlayer = $finishRoll

# Pool of ids
var gacha_pool := [
	{
		"id": "exchange_desk",
		"texture": preload("res://assets/images/gacha/exchangedesk.png"),
		"name": "Exchange Desk",
		"rarity": "SSR",
		"weight": 5
	},
	{
		"id": "easel",
		"texture": preload("res://assets/images/gacha/easel.png"),
		"name": "Easel",
		"rarity": "R",
		"weight": 30
	},
	{
		"id": "globe",
		"texture": preload("res://assets/images/gacha/globe.png"),
		"name": "Globe",
		"rarity": "SR",
		"weight": 20
	},
	{
		"id": "goggle",
		"texture": preload("res://assets/images/gacha/goggle.png"),
		"name": "Goggle",
		"rarity": "R",
		"weight": 30
	},
	{
		"id": "orange",
		"texture": preload("res://assets/images/gacha/orange.png"),
		"name": "Orange",
		"rarity": "C",
		"weight": 50
	},
	{
		"id": "tree",
		"texture": preload("res://assets/images/gacha/tree.png"),
		"name": "Tree",
		"rarity": "SR",
		"weight": 15
	}
]

func _ready() -> void:
	color_rect.visible = false
	texture_rect.custom_minimum_size = Vector2(250, 250)


func pull_item() -> Dictionary:
	var total_weight = 0
	for item in gacha_pool:
		total_weight += item.weight
	
	# get total weight and an integer between 0 - total weight
	var result = randi() % total_weight
	var culm = 0
	# For each item, add up their weights. if it exceeds the number generated, then return that item
	for item in gacha_pool:
		culm += item.weight
		if culm > result:
			return item
	return {}

func _on_button_pressed() -> void:
	rollsound.play()
	screen_image.play("pulling")
	curr_anim = "pulling"

func get_rarity_color(rarity: String) -> Color:
	match rarity:
		"C": return Color.GRAY
		"R": return Color.BLUE
		"SR": return Color.PURPLE
		"SSR": return Color.GOLD
		_: return Color.WHITE

func _on_screen_image_animation_finished() -> void:
	if curr_anim == "pull_end":
		await get_tree().create_timer(2.3).timeout
		curr_anim = "idle"
		screen_image.play("idle")

	if curr_anim == "pulling":
		screen_image.play("pull_end")
		curr_anim = "pull_end"
		
		var item = pull_item()
		match item.rarity:
			"C": $finishRoll.play()
			"R": $finishRoll.play()
			"SR": $SRRoll.play()
			"SSR": 
				$SRRoll.play()
				$SSR.play()
			_: $finishRoll.play()
		label.text = "[%s] %s" % [item.rarity, item.name]
		label.add_theme_color_override("font_color", get_rarity_color(item.rarity))
		texture_rect.texture = item.texture

		texture_rect.modulate.a = 0.0
		texture_rect.scale = Vector2(1, 1)
		label.modulate.a = 0.0
		color_rect.modulate.a = 0.0
		color_rect.visible = true

		var tween = get_tree().create_tween()

		item_reveal(texture_rect, tween)
		if item.rarity == "R":
			tween.tween_interval(0.3)
			var original_pos = texture_rect.position
			tween.tween_property(texture_rect, "position", original_pos + Vector2(20, 0), 0.05)
			tween.tween_property(texture_rect, "position", original_pos - Vector2(20, 0), 0.05)
			tween.tween_property(texture_rect, "position", original_pos + Vector2(10, 0), 0.05)
			tween.tween_property(texture_rect, "position", original_pos, 0.05)
		elif item.rarity == "SR":
			tween.tween_interval(0.1)
			var original_pos = texture_rect.position
			tween.tween_property(texture_rect, "position", original_pos + Vector2(70, 0), 0.03)
			tween.tween_property(texture_rect, "position", original_pos - Vector2(60, 0), 0.03)
			tween.tween_property(texture_rect, "position", original_pos + Vector2(70, 0), 0.03)
			tween.tween_interval(0.1)
			tween.tween_property(texture_rect, "position", original_pos + Vector2(20, 0), 0.03)
			tween.tween_property(texture_rect, "position", original_pos - Vector2(10, 0), 0.03)
			tween.tween_property(texture_rect, "position", original_pos + Vector2(20, 0), 0.03)
			tween.tween_property(texture_rect, "position", original_pos, 0.05)
		elif item.rarity == "SSR":
			tween.tween_interval(0.1)
			var original_pos = texture_rect.position
			tween.tween_property(texture_rect, "position", original_pos + Vector2(70, 0), 0.03)
			tween.tween_property(texture_rect, "position", original_pos - Vector2(60, 0), 0.03)
			tween.tween_property(texture_rect, "position", original_pos + Vector2(80, 0), 0.03)
			var i = 0
			while i < 5:
				tween.tween_property(texture_rect, "position", original_pos + Vector2(20, 0), 0.03)
				tween.tween_property(texture_rect, "position", original_pos + Vector2(40, 0), 0.03)
				i += 1
			tween.tween_property(texture_rect, "position", original_pos, 0.05)
		elif item.rarity == "C":
			pass

		tween.parallel().tween_property(label, "modulate:a", 1.0, 0.4).set_delay(0.2)
		tween.parallel().tween_property(color_rect, "modulate:a", 0.6, 0.5)

		tween.tween_interval(0.8)
		tween.tween_property(color_rect, "modulate:a", 0.0, 0.4)
		tween.parallel().tween_property(texture_rect, "modulate:a", 0.0, 0.4)
		tween.parallel().tween_property(label, "modulate:a", 0.0, 0.4)

		tween.tween_callback(func(): color_rect.visible = false)

func item_reveal(target: TextureRect, tween: Tween) -> void:
	var original_pos = target.position
	target.position = original_pos

	tween.tween_property(target, "modulate:a", 1.0, 0.2)
	tween.tween_property(target, "scale", Vector2(1, 1), 0.3).set_trans(Tween.TRANS_BACK).set_delay(0.1)
