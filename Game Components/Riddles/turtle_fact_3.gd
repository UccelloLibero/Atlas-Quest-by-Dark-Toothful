# TurtleFact3.gd
extends Area2D

# Reference nodes of BeeRiddle1 scene
@onready var label_text_holder = $ColorRect
@onready var label_text = $ColorRect/Label
@onready var timer = $Timer

# Exported variable to set duration of label visibility
@export var label_duration = 8.0

# Variable to store reference to the player
var player = null

# Hide riddle on start
func _ready():
	label_text_holder.visible = false
	label_text.visible = false
	$Timer.one_shot = true
	$Timer.wait_time = label_duration

# When player enters the collision boundry
func _on_body_entered(body):
	if body.name == "Player":
		player = body
		# Disable player movement
		player.can_move = false
		label_text_holder.visible = true
		label_text.visible = true
		$Timer.start()
		

# After timer times out, clear the scene of the ColorRect and label
func _on_timer_timeout():
	label_text_holder.visible = false
	label_text.visible = false
	# Enable player movement
	if player != null:
		player.can_move = true
	player = null
	queue_free()


