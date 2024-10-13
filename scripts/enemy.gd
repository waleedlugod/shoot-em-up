class_name Enemy 
extends Area2D

@export var speed: float = 150
var player = null
var canshoot = true
@export var health = 6

var bullet = preload("res://scenes/enemy_bullet.tscn")
signal laser_shot(laser_scene, location)

@onready var muzzle = $Muzzle

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.player_health()
		enemy_health()
	
func enemy_health():
	health -= 1
	if health == 0:
		queue_free()


func _on_detection_body_entered(body):
	if body.is_in_group("player"):
		player = body
		
func _on_shootspeed_timeout():
	laser_shot.emit(bullet, muzzle.global_position)
	$Shootspeed.start()
