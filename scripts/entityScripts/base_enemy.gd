extends entity

func _ready() -> void:
	_connect_processes()
	self.add_to_group("enemy")
