class_name Enemy 
extends Area2D

@export var speed: float = 150
var canshoot = true
@export var health = 6

var bullet = preload ("res://scenes/enemy_bullet.tscn")

@onready var muzzle = $Muzzle

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.player_health()
		queue_free()
	
func enemy_health():
	health -= 1
	if health == 0:
		queue_free()
		
func _on_shootspeed_timeout():
	canshoot = true
	shoot()
		
func shoot():
	if canshoot:
		var bullet = bullet.instantiate()
		bullet.position = muzzle.global_position
		get_parent().add_child(bullet)
		
		$Shootspeed.start()
		canshoot = false
