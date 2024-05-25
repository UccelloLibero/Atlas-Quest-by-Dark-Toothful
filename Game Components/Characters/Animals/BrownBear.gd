# Bear.gd
extends CharacterBody2D

@onready var bear_animation = $AnimatedSprite2D
@onready var bear_label = $ColorRect/Label
@onready var label_bg = $ColorRect
@onready var timer = $Timer

# Exported variable to adjust the label visibility time (8 seconds)
@export var label_duration = 8.0

# Get bear ready to follow the player
@export var follow_speed = 50
@onready var player: CharacterBody2D = null
# Minimum distance to maintain from the player
@export var min_distance = 50 
var is_following = false
@export var offset = Vector2(-50, 0)

const IDLE_ANIMATION = "idle"
const WALK_ANIMATION = "walk"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Flag to check if label has been shown
var label_shown = false

# Called every frame. 'delta' is the elapsed time sine the previous frame.
func _process(delta):
	if is_following and player:
		var target_position = player.position.x + offset.x
		var distance_to_player = abs(target_position - position.x)
		
		if distance_to_player > min_distance:
			var direction = sign(target_position - position.x)
			var velocity = Vector2(direction * follow_speed, 0)
			var collision = move_and_collide(velocity * delta)
			
			# Adjust animation and flip direction based on movement
			if direction < 0:
				bear_animation.flip_h = true
				bear_animation.play(WALK_ANIMATION)
			elif direction > 0:
				bear_animation.flip_h = false
				bear_animation.play(WALK_ANIMATION)
		else:
			bear_animation.play(IDLE_ANIMATION)
	else:
		bear_animation.play(IDLE_ANIMATION)
		
	
# Called when the node enters the scene tree for the first time.
func _ready():
	bear_animation.play("idle")
	# Hide label and timer initially
	label_bg.visible = false
	bear_label.visible = false
	timer.one_shot = true
	timer.wait_time = label_duration


func _on_area_2d_body_entered(body):
	print("Body entered: ", body.name) # For debugging
	if body.name == "Player" and body is CharacterBody2D:
		if not label_shown:
			label_bg.visible = true
			bear_label.visible = true
			timer.start()
			label_shown = true # Set the flag to true to show the label only once
		
		is_following = true
		player = body


		
# Hide the label when the timer times out
func _on_timer_timeout():
	label_bg.visible = false
	bear_label.visible = false
	





