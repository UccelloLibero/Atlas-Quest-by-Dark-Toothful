
extends CharacterBody2D

const SPEED = 50.0
const IDLE_ANIMATION = "idle"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

# Declare whether character is dead or alive
var _died = false

#A variable that tracks the player's proximity to the enemy
var player_in_range = false

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Get a reference to the player node
	var player = get_parent().get_node("Player") #Adjust path to player
	
	#Check if the player exists and is in range
	if player:
		var distance_to_player = global_position.distance_to(player.global_position) 
		if distance_to_player < 80: #Adjust as necessary
			player_in_range = true
		else:
			player_in_range = false
	
	#Play running animation based on player's proximity
	if player_in_range:
		#Run toward player
		animated_sprite.play("run")
		#Move towards player (left direction)
		move_towards_player(player)
			
	else:
		# Reset velocity and play idle animation
		velocity = Vector2.ZERO
		animated_sprite.play(IDLE_ANIMATION)
		
	move_and_slide()


#Function to get enemy to move to the left
func move_towards_player(player):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	velocity.y += gravity #enemy only moves left and right
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
func _ready():
	animated_sprite.play(IDLE_ANIMATION)


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		animated_sprite.play("die")
		body.take_damage()




############################# 

## Poacher.gd 
#extends CharacterBody2D
#
#@onready var animation_poacher = $AnimatedSprite2D
#@onready var shoot_effect = $PoacherEffect
#@onready var vision_ray_cast = $VisionRayCast
#@onready var action_timer = $ActionTimer  # Reference to the Timer node
#@onready var delay_timer = $DelayTimer
#
#
#var speed = 50
#var health = 1
#var is_interacting = false  # A flag to check if interacting with the player
#var facing_left = true  # Default facing direction
#
#func _ready():
	#vision_ray_cast.enabled = true
	#action_timer.start()
	## Connect the "timeout" signal using Callable
	#delay_timer.connect("timeout", Callable(self, "_on_DelayTimer_timeout"))
#
#func _physics_process(delta):
	#if vision_ray_cast.is_colliding():
		#var collider = vision_ray_cast.get_collider()
		#if collider.name == "Player":
			#face_player(collider)
			#attack_player(collider)
			#is_interacting = true
	#else:
		#is_interacting = false
		#
	#move_and_slide()
	#
	#
#func _on_action_timer_timeout():
	#if not is_interacting:
		#facing_left = !facing_left
		#if facing_left:
			#animation_poacher.play("idle")
			#scale.x = -abs(scale.x)
		#else:
			#animation_poacher.play("idle")
			#scale.x = abs(scale.x)
		#delay_timer.start()
		#
#func _on_DelayTimer_timeout():
	#animation_poacher.play("idle")
#
## Function to face the player based on their position
#func face_player(body):
	#if body.name == "Player" and body.global_position.x < global_position.x and not facing_left:
		#scale.x = -abs(scale.x)
		#facing_left = true
	#elif body.global_position.x > global_position.x and facing_left:
		#scale.x = abs(scale.x)
		#facing_left = false
#
## Function to handle attacking the player
#func attack_player(body):
	#if body.name == "Player":
		#shoot_effect.play("shoot")
		#animation_poacher.play("shoot")
		#body.take_damage()
#
#func take_hit():
	#health -= 1
	#if health <= 0:
		#die()
#
#func die():
	#animation_poacher.play("die")
	#await animation_poacher.animation_finished
	#queue_free()
#
#
#
#
#func _on_area_2d_body_entered(body):
	#if body.name == "Player":
		#animation_poacher.play("die")
		#queue_free()
