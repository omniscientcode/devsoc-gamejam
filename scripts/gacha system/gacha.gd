extends Node2D

# Pool of ids
var gacha_pool: = [
	{"id": "exchange_desk", "name": "Exchange Desk", "rarity": "ssr", "weight": 5}
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
		culm += item.weight()
		if culm > result:
			return item
	return {}
