extends CharacterBody2D

# Reference the AnimatedSprite2D node inside the Player scene
@onready var animated_sprite = $AnimatedSprite2D

# Reference a timer node 
@onready var reset_timer = $ResetTimer

# Player movement variables
@export var speed = 150
@export var gravity = 200
@export var jump_heigh = -250

# Movement states
var is_attacking = false
var is_climbing = false

# Movement and physics 
func _physics_process(delta):
	# Vertical movement velocity (down)
	velocity.y += gravity * delta
	# Horizontal movement processing (left, right)
	horizontal_movement()
	# Applies movement
	move_and_slide()
	# Applies animations
	if !is_attacking:
		player_animations()

# Handle movement
func horizontal_movement():
	# if keys are pressed it will return 1 for ui_right, -1 for ui_left, and 0 for neither
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# horizontal velocity which moves player left or right based on input
	velocity.x = horizontal_input * speed
	
# Animations
func player_animations():
	# On left (add is_action_just_released so we can continue running after jumping)
	if Input.is_action_pressed("ui_left") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
		
	# On right (add is_action_just_released so we can continue running after jumping 
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
	
	# On idle if nothing is being pressed
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
	
	# If player is moving downward (falling after jump)
	if velocity.y > 0 and !is_on_floor():
		$AnimatedSprite2D.play("fall")

# Singular input captures
func _input(event):
	# On attack
	if event.is_action_pressed("ui_accept"):
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		
	# On jump
	if event.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_heigh
		$AnimatedSprite2D.play("jump")
		
	# On climbing ladders
	if is_climbing == true:
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("climb")
			gravity = 100
			velocity.y = -200
	# Reset gravity		
	else:
		gravity = 200
		is_climbing = false
		
	
	
# Handle death when player enters death zone water, sand, falls into abyss
func _on_death_zone_body_entered(body):
	if body == self:
		reset_timer.start()

# Timer timeout signal handler
func _on_reset_timer_timeout():
	# Reset level or set the player's position to the starting point
	global_position = Vector2(89,-65) # Update to desired starting point for each level
	velocity = Vector2.ZERO # Reset velocity
	


# Signal to stop attack and climbing loop after single input press
func _on_animated_sprite_2d_animation_finished():
	is_attacking = false
	is_climbing = false
