extends Node2D

func _ready():
	get_today_date()

func get_today_date() -> String:
	var date = Time.get_date_dict_from_system()
	return "%04d-%02d-%02d" % [date.year, date.month, date.day]

const QUESTS = {
	"study for 1 hour!": {
		"goal": 60,
		"progress": 0,
		"completed": false
	}
}
