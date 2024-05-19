# Bee.gd
extends Area2D

@onready var bee_animation = $AnimatedSprite2D
@onready var bee_label = $ColorRect/Label
@onready var label_bg = $ColorRect
@onready var timer = $Timer

# Exported variable to adjust the label visibility time (8 seconds)
@export var label_duration = 8.0

# Get bee ready to follow the player
@export var follow_speed := 200
@onready var player: CharacterBody2D = null
var is_following := false
@export var offset := Vector2(0, -50)


# Flag to check if label has been shown
var label_shown := false

# Called every frame. 'delta' is the elapsed time sine the previous frame.
func _process(delta):
	if is_following and player:
		# Calculate the target position with the offset
		var target_position = player.position + offset
		# Move towards player
		position = position.move_toward(target_position, follow_speed * delta)
		

# Called when the node enters the scene tree for the first time.
func _ready():
	bee_animation.play("idle")
	# Hide label and timer initially
	label_bg.visible = false
	bee_label.visible = false
	timer.one_shot = true
	timer.wait_time = label_duration
	


# Show label when the player enters the Bee area
func _on_body_entered(body):
	#print("Body entered: ", body.name) # For debugging
	if body.name == "Player" and body is CharacterBody2D:
		if not label_shown:
			label_bg.visible = true
			bee_label.visible = true
			timer.start()
			label_shown = true # Set the flag to true to show the label only once
		
		is_following = true
		player = body

		
# Hide the label when the timer times out
func _on_timer_timeout():
	label_bg.visible = false
	bee_label.visible = false
	

