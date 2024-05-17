# player.gd
extends CharacterBody2D

# Reference the AnimatedSprite2D node inside the Player scene
@onready var animated_sprite = $AnimatedSprite2D

# Reference a timer node 
@onready var reset_timer = $ResetTimer

# Reference the AttackRayCast node
@onready var attack_ray_cast = $AttackRayCast

# Reference the energy label
@onready var energy_warning_label = $EnergyWarningLabel

# Reference Death zone dying sound in tree
@onready var death_zone_sound_audio = $DeathZoneSound

# Player movement variables
@export var speed : float = 200.0
@export var gravity = 980
@export var jump_height : float = -215.0

# Custom signals
signal update_lives(lives, max_lives)
signal update_biofacts(biofacts)
signal update_energy(energy)

# Death zone sound preload
var death_zone_sound = preload("res://Assets/Sounds/deathzone.mp3")

# Life statistics
var max_lives = 3
var lives = 3
#var is_hurt = false

# Biofact statistics
var biofacts = int()

# Energy statistics
var energy = 0

func _ready():
	# Update UI labels when signals are emited
	update_lives.connect($UI/Lives.update_lives)
	update_biofacts.connect($UI/Biofacts.update_biofacts)
	update_energy.connect($UI/Energy.update_energy)
	
	# Show correct lives value on load
	$UI/Lives/Label.text = str(lives)
	# Show correct number of biofacts value on load
	$UI/Biofacts/Label.text = str(biofacts)
	# Show curreny energy value on load
	$UI/Energy/Label.text = str(energy)

# Movement and physics 
func _physics_process(delta):
	# Vertical movement velocity (down)
	velocity.y += gravity * delta
	# Horizontal movement processing (left, right)
	horizontal_movement()
	# Applies movement
	move_and_slide()
	# Applies animations
	if !Global.is_climbing:
		player_animations()
		
	# Attacking
	if Global.is_attacking == true:
		# Get colliders of raycast node
		var target = $AttackRayCast.get_collider()
		# If its valid
		if target != null:
			# Remove poacher
			if target.name == "Poacher":
				target.play("die")
				
				


# Handle  horizontal movement
func horizontal_movement():
	# if keys are pressed it will return 1 for ui_right, -1 for ui_left, and 0 for neither
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# horizontal velocity which moves player left or right based on input
	velocity.x = horizontal_input * speed

	
# Animations
func player_animations():
	# On left (add is_action_just_released so we can continue running after jumping) and not hurt
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
	if event.is_action_pressed("ui_attack"):
		Global.is_attacking = true
		$AnimatedSprite2D.play("attack")
		
	# On jump
	if event.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("jump")
		
	# On climbing ladders
	if Global.is_climbing == true:
		if !Input.is_anything_pressed():
			$AnimatedSprite2D.play("idle")
		
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("climb")
			gravity = 100
			velocity.y = -160
			Global.is_jumping = true
	# Reset gravity		
	else:
		gravity = 200
		Global.is_climbing = false
		Global.is_jumping = false
		

# Signal to stop attack and climbing loop after single input press
# Reset animation variables
func _on_animated_sprite_2d_animation_finished():
	Global.is_attacking = false
	Global.is_climbing = false
	set_physics_process(true)
	#is_hurt = false

	
# Handle death when player enters death zone water, sand, falls into abyss
func _on_death_zone_body_entered(body):
	if body == self:
		death_zone_sound_audio.stream = death_zone_sound
		death_zone_sound_audio.play()
		await death_zone_sound_audio.finished
		get_tree().reload_current_scene()
		#reset_timer.start()

# Timer timeout signal handler to reset player to begging of level after falling to abyss
func _on_reset_timer_timeout():
	# Reset level or set the player's position to the starting point
	global_position = Vector2(89,-65) # Update to desired starting point for each level
	velocity = Vector2.ZERO # Reset velocity
	

# Takes damage
func take_damage():
	# Deduct and update live
	if lives > 0:
		lives = lives - 1
		update_lives.emit(lives, max_lives)
		print(lives)
		# Play damage animation
		$AnimatedSprite2D.play("damage")
		# Allow animation "damage" to play
		set_physics_process(false)
		
		
		#is_hurt = true
	if lives == 0:
		$AnimatedSprite2D.play("die")
		#await $AnimatedSprite2D.animation_finished
		get_tree().reload_current_scene()
		
		
	# Add flashing effect to show damage 
	$AnimatedSprite2D.modulate = Color.DARK_RED
	await create_flash_timer()
	$AnimatedSprite2D.modulate = Color.WHITE

# Reduce energy on impace with large animals
func reduce_energy():
	# Decrese energy
	if energy >= 5:
		energy -= 5
		update_energy.emit(energy)
		
	if energy == 0 and lives == 0:
		update_energy.emit(energy)
		$AnimatedSprite2D.play("die")
		get_parent().get_tree().reload_current_scene()
	elif energy == 0 and lives > 0:
		#energy_warning_label.text = "You are running low on energy! Eat more fruit"
		update_energy.emit(energy)


	# Add flashing effect to show damage 
	$AnimatedSprite2D.modulate = Color.CRIMSON
	await get_tree().create_timer(0.2).timeout
	$AnimatedSprite2D.modulate = Color.WHITE
	
func create_flash_timer():
	if get_tree():
		await get_tree().create_timer(0.2).timeout
	

# Adds life and biofacts to the player and updates lives/biofact count
func add_life_biofact(collect):
	# Increase life count if player does not have three lives already
	if collect == Global.LifeBiofact.LIFE:
		if lives < max_lives:
			lives += 1
			update_lives.emit(lives, max_lives)
			
	# Temoporarily allows to remove and increase biofacts
	if collect == Global.LifeBiofact.BIOFACT:
		biofacts += 1
		update_biofacts.emit(biofacts)
		
# Add Energy to player and update energy
func add_energy(fruit):
	# Increase energy count
	if fruit == Global.Energy.APPLE:
		energy += 5
		update_energy.emit(energy)
	if fruit == Global.Energy.BANANAS:
		energy += 5
		update_energy.emit(energy)
	if fruit == Global.Energy.CHERRIES:
		energy += 5
		update_energy.emit(energy)
	if fruit == Global.Energy.PINEAPPLE:
		energy += 5
		update_energy.emit(energy)
	if fruit == Global.Energy.STRAWBERRY:
		energy +=5
		update_energy.emit(energy)


	
	
