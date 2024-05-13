extends CharacterBody2D

const SPEED = 50.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

@export_enum(
	"left",
	"right",
	"active",
) var moving_direction: String

@export_enum(
	"idle",
	"run",
) var animation: String

#Define some variables for movement
var _gravity = 10
var _speed = 10
var _moving_left = true
var _body: Node2D
var _hit_to_die = 3
var _has_hits = 0
var die = false
var _stop_detection = false

#A variable that tracks the player's proximity to the enemy
var player_in_range = false
	
func _ready():
	if moving_direction == 'right':
		_moving_left = false
		scale.x = -scale.x
		$AnimatedSprite2D.flip_h = false
	if not animation:
		animation = "idle"
	_init_state()  ## this needs to connect to something later

func calculate_ai_movement() -> Vector2:
	# Your logic to calculate AI movement goes here
	# For example, you might want to move towards a target position
	var target_position = Vector2.ZERO  # Replace this with your target position logic
	var direction = (target_position - global_position).normalized()
	var movement = direction * SPEED
	
	return movement

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var movement = calculate_ai_movement()
	
	move_and_slide()
	
	var player = get_parent().get_node("Player")
	if (die): 
		return
	
	if animation == "run":
		_move_character(delta)
	elif animation == "idle":
		_move_idle()
	
	#Check if the player exists and is in range
	if player:
		var distance_to_player = global_position.distance_to(player.global_position) 
		if distance_to_player < 50: #Adjust as necessary
			player_in_range = true
	else:
		player_in_range = false
	
	#Play running animation based on player's proximity
	if player_in_range:
		#Run toward player
		animated_sprite.play("run")
		#Move towards player (left direction)
		move_towards_player(player)
		
func _move_character(_delta):# Add the gravity.
	velocity.y += _gravity
	
	if _moving_left:
		velocity.x = - _speed
		
	else: 
		velocity.x = _speed
	
	move_and_slide()

func _move_idle():
	velocity.y += _gravity
	velocity.x = 0
	move_and_slide()
	
func _attack():
	animated_sprite.play("run")
	# Get a reference to the player node
	var player = get_parent().get_node("Player") #Adjust path to player

func _init_state():

	velocity.x = 0
	animated_sprite.play("idle")
	
	_body = null
	_stop_detection = false
	
func _move(_direction):

	velocity.y += _gravity


#Function to get enemy to move to the left
func move_towards_player(player):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	velocity.y = 0 #enemy only moves left and right

func reset():
	die = false
