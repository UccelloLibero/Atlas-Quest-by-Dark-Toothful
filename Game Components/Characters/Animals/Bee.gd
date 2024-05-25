# Bee.gd
extends Area2D

@onready var bee_animation = $AnimatedSprite2D


# Get bee ready to follow the player
@export var follow_speed = 150
@onready var player: CharacterBody2D = null
var is_following = false
@export var offset = Vector2(-50, -100)

var oscillation_speed = 5 # Speed of the oscillation
var oscillation_amplitude = 5 # Amplitude of the oscillation
var oscillation_time = 0.0
var last_player_position = Vector2()


# Called every frame. 'delta' is the elapsed time sine the previous frame.
func _process(delta):
	if is_following and player:
		# Calculate the target position with the offset
		var target_position = player.position + offset
		# Move towards player
		position = position.move_toward(target_position, follow_speed * delta)
		
		# Flip the sprite based on player's relative position
		if position.x < player.position.x:
			bee_animation.flip_h = true
		else:
			bee_animation.flip_h = false
		
		# Check if the player has stopped moving
		if player.position.distance_to(last_player_position) < 1:
			# Swivel back and forth
			oscillation_time += delta * oscillation_speed
			position.x += sin(oscillation_time) * oscillation_amplitude
		else:
			last_player_position = player.position
	else:
		# Swivel back and forth when not following
		oscillation_time += delta * oscillation_speed
		position.x += sin(oscillation_time) * oscillation_amplitude

		

# Called when the node enters the scene tree for the first time.
func _ready():
	bee_animation.play("fly")


# Follow player when player enters area
func _on_body_entered(body):
	#print("Body entered: ", body.name) # For debugging
	if body.name == "Player" and body is CharacterBody2D:
		is_following = true
		player = body
		last_player_position = player.position
		
	
