class_name Enemy 
extends Area2D

@export var speed: float = 150

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()
	
