extends Resource 

class_name Spawn_info

@export var NAME:String
@export var enemy: PackedScene 
@export var ENEMY_NUMBER:int # Number of enemies spawned at a time
@export var SPAWN_DELAY: float # Delay  between enemy spawns

var SPAWN_DELAY_COUNTER = 0 # Counts delay between enemy spawns
