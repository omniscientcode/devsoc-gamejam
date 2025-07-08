extends Node

# Path for saving
var SAVEFILE = "user://SAVEFILE.dat"

# On ready load data
func _ready():
	OS.set_low_processor_usage_mode(true)
	load_data()

func load_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE): # If data doesn't exist in file set to default
		var loaded_player_data = file.get_var()
		
	else:
		save_data()

func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	var player_data = create_player_data()
	file.store_var(player_data)

func create_player_data():
	var player_dict = {
	}
	return player_dict
