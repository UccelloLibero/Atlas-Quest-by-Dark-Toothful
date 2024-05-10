extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const IDLE_ANIMATION = "idle"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

# Declare whether character is dead or alive
var _died = false

#A variable that tracks the player's proximity to the enemy
var player_in_range = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
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
		print("Playing run animation")
		animated_sprite.play("run")
		#Move towards player (left direction)
		move_towards_player(player)
	else:
		print("Playing idle animation")
		animated_sprite.play(IDLE_ANIMATION)


#Function to get enemy to move to the left
func move_towards_player(player):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	velocity.y = 0 #enemy only moves left and right
	
func _ready():
	animated_sprite.play(IDLE_ANIMATION)
