extends CharacterBody2D


# Set up signal
signal hit
# Player movement variables 


const SPEED = 100.0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Reference the AnimatedSprite2D node inside the Player scene
@onready var animated_sprite = $AnimatedSprite2D

# Reference a timer node 
@onready var reset_timer = $ResetTimer

# Declare whether character is dead or alive
var _died = false

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		# Jump animation 
		if(velocity.y <= 0):
			animated_sprite.animation = "jump"
		else:
			animated_sprite.animation = "fall"
			
	else:
		if(velocity.x == 0): # If player not moving animation is set to idle
			animated_sprite.animation = "idle"
		else: # If player is moving it is playing running annimation
			animated_sprite.animation = "run"
			
			
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		# Flip direction of the player left to right only when moving left/right horizontally
		if(velocity.x < 0):
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()
	
	
# Handle death
func _on_death_zone_body_entered(body):
	if body == self:
		reset_timer.start()
	
	



func _on_reset_timer_timeout():
	# Reset level or set the player's position to the starting point
	global_position = Vector2(89,-65) # Update to desired starting point for each level
	velocity = Vector2.ZERO # Reset velocity


func _on_restet_timer_timeout():
	pass # Replace with function body.
