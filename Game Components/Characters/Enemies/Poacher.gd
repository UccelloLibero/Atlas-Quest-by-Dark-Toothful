# Poacher.gd 
extends CharacterBody2D

@onready var animation_poacher = $AnimatedSprite2D
@onready var shoot_effect = $PoacherEffect
@onready var vision_ray_cast = $VisionRayCast
@onready var action_timer = $ActionTimer  # Reference to the Timer node
@onready var delay_timer = $DelayTimer


var speed = 50
var health = 1
var is_interacting = false  # A flag to check if interacting with the player
var facing_left = true  # Default facing direction

func _ready():
	vision_ray_cast.enabled = true
	action_timer.start()
	# Connect the "timeout" signal using Callable
	delay_timer.connect("timeout", Callable(self, "_on_DelayTimer_timeout"))

func _physics_process(delta):
	if vision_ray_cast.is_colliding():
		var collider = vision_ray_cast.get_collider()
		if collider.name == "Player":
			face_player(collider)
			attack_player(collider)
			is_interacting = true
	else:
		is_interacting = false
		
	move_and_slide()
	
	
func _on_action_timer_timeout():
	if not is_interacting:
		facing_left = !facing_left
		if facing_left:
			animation_poacher.play("idle")
			scale.x = -abs(scale.x)
		else:
			animation_poacher.play("idle")
			scale.x = abs(scale.x)
		delay_timer.start()
		
func _on_DelayTimer_timeout():
	animation_poacher.play("idle")

# Function to face the player based on their position
func face_player(body):
	if body.name == "Player" and body.global_position.x < global_position.x and not facing_left:
		scale.x = -abs(scale.x)
		facing_left = true
	elif body.global_position.x > global_position.x and facing_left:
		scale.x = abs(scale.x)
		facing_left = false

# Function to handle attacking the player
func attack_player(body):
	if body.name == "Player":
		shoot_effect.play("shoot")
		animation_poacher.play("shoot")
		body.take_damage()

func take_hit():
	health -= 1
	if health <= 0:
		die()

func die():
	animation_poacher.play("die")
	queue_free()


