extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var spawn_point = $spawn_point
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score

#Get make sure that there is always a player on screen
func _ready():
	score = 0
	player = get_tree().get_first_node_in_group("player")
	#Will create an error if player is not found
	assert(player != null)
	#Make player appear at spawn point when game is started
	player.global_position = spawn_point.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
			get_tree().quit()
			
	elif Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
			
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate() 
	laser.global_position = location
	laser_container.add_child(laser)


func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 1000), -50)
	e.killed.connect(_on_enemy_killed)
	e.laser_shot.connect(_on_player_laser_shot)
	enemy_container.add_child(e)
	
func _on_enemy_killed():
	score += 100

func _on_player_killed():
	gos.set_score(score)
	print("Player killed. Showing Game Over screen.")
	await get_tree().create_timer(1.5).timeout
	gos.visible = true
