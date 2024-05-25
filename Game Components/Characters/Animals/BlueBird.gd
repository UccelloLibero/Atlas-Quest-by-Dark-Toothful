# BlueBird.gd
extends CharacterBody2D

@onready var bird_animation = $AnimatedSprite2D

@export var fly_speed = 200 # Speed of the bird's flight
@export var fly_distance = 50 # Distance the bird will fly before turning around
@export var wait_time = 1.0 # Time to wait before turning around

var direction = 1 # 1 for right, -1 for left
var distance_travelled = 0.0
var wait_timer = 0.0

func _process(delta):
	if wait_timer > 0:
		wait_timer -= delta
		return
	
	# Move the bird
	var movement = Vector2(direction * fly_speed * delta, 0)
	move_and_collide(movement)
	
	# Track distance travelled
	distance_travelled += abs(movement.x)
	
	if distance_travelled >= fly_distance:
		# Turn around
		direction *= -1
		distance_travelled = 0.0
		wait_timer = wait_time
		
		# Flip the bird sprite
		bird_animation.flip_h = direction > 0

# Called when the node enters the scene tree for the first time.
func _ready():
	bird_animation.play("fly")
	bird_animation.flip_h = direction > 0
