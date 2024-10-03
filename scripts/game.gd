extends Node2D

@onready var spawn_point = $spawn_point

var player = null

#Get make sure that there is always a player on screen
func _ready():
	player = get_tree().get_first_node_in_group("player")
	#Will create an error if player is not found
	assert(player != null)
	#Make player appear at spawn point when game is started
	player.global_position = spawn_point.global_position

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
			get_tree().quit()
			
	elif Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
