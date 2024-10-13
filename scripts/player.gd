class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)

@export var speed = 300

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/laser.tscn")

@onready var animated_sprite = $AnimatedSprite2D

var shoot_cooldown := false
var health = 3
var is_exploded = false

func _process(_delta):
	if Input.is_action_pressed("shoot") and not is_exploded:
		if !shoot_cooldown:
			shoot_cooldown = true
			shoot()
			await get_tree().create_timer(0.20).timeout
			shoot_cooldown = false

func _physics_process(_delta):
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	velocity = direction * speed
	if not is_exploded: move_and_slide()
	
	#Clamp the player so that it wont exit the viewport
	global_position.x = clamp(global_position.x, 10, 950)
	global_position.y = clamp(global_position.y, 10, 1150)


func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)
	
func die():
	queue_free()

func player_health():
	health -= 1
	if health == 0:
		animated_sprite.play("explode")
		is_exploded = true
		await animated_sprite.animation_finished
		queue_free()
