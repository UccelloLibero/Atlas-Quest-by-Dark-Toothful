# PoacherGreen.gd
extends CharacterBody2D

const SPEED = 50.0
const IDLE_ANIMATION = "idle"
var gravity = 100

#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

# Declare whether character is dead or alive
#var _died = false

# A variable that tracks the player's proximity to the enemy
var player_in_range = false
var player_in_contact = false

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Get a reference to the player node
	var player = get_parent().get_node("Player") # Adjust path to player
	
	# Check if the player exists and is in range
	if player:
		var distance_to_player = global_position.distance_to(player.global_position) 
		if distance_to_player < 80: 
			player_in_range = true
		else:
			player_in_range = false
	
	# Play animation based on player's proximity
	if player_in_contact:
		# Play stunned animation when in contact with the player
		animated_sprite.play("stunned")
	elif player_in_range:
		# Run toward player
		animated_sprite.play("run")
		# Move towards player (left direction)
		move_towards_player(player)
			
	else:
		# Reset velocity and play idle animation
		velocity = Vector2.ZERO
		animated_sprite.play(IDLE_ANIMATION)
		
	move_and_slide()


# Function to get enemy to move to the left
func move_towards_player(player):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	velocity.y += gravity 
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
func _ready():
	animated_sprite.play(IDLE_ANIMATION)

# Deal damage and monitior players distance for vector reset
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_contact = true
		body.take_damage()

# Poacher vector reset
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_contact = false
