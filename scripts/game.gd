extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var spawn_point = $spawn_point
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer

var player = null

#Get make sure that there is always a player on screen
func _ready():
	player = get_tree().get_first_node_in_group("player")
	#Will create an error if player is not found
	assert(player != null)
	#Make player appear at spawn point when game is started
	player.global_position = spawn_point.global_position
	player.laser_shot.connect(_on_player_laser_shot)

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
			get_tree().quit()
			
	elif Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
			
func _on_player_laser_shot(laser_scene, location):
	print('shoot')
	var laser = laser_scene.instantiate() 
	laser.global_position = location
	laser_container.add_child(laser)


func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 1000), -50)
	e.laser_shot.connect(_on_player_laser_shot)
	enemy_container.add_child(e)
