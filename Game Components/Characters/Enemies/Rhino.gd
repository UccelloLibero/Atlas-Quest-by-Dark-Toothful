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
	# Handle jump.
	
	# Get a reference to the player node
	var player = get_parent().get_node("Player") #Adjust path to player
	
	#Check if the player exists and is in range
	if player:
		var distance_to_player = global_position.distance_to(player.global_position) 
		if distance_to_player < 60: #Adjust as necessary
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
		animated_sprite.play(IDLE_ANIMATION)

	move_and_slide() #When this is active, the rhino floats above the ground

#Function to get enemy to move to the left
func move_towards_player(player): # Make updates in here so rhino isn't floating
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	velocity.y += gravity #enemy only moves left and right
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = false
	else: 
		$AnimatedSprite2D.flip_h = true

	
func _ready():
	animated_sprite.play(IDLE_ANIMATION)


# I also need a reset function so that the rhino resets to original position upon player death
