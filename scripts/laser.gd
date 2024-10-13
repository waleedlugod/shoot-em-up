extends Area2D

@export var speed = 600
var is_exploded = false

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_exploded: global_position.y += -speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	

func _on_area_entered(area):
	if area.has_method("enemy_health"):
		print(area.name)
		animated_sprite.play("hit")
		is_exploded = true
		area.enemy_health()
		await animated_sprite.animation_finished
		queue_free()
	

func _on_despawntimer_timeout():
	queue_free()
