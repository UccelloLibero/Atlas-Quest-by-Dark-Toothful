# FinalBeeRiddleQ.gd
extends Area2D

@onready var riddle_display = $ColorRect
@onready var label_text = $ColorRect/Label
@onready var button_correct = $ColorRect/Button
@onready var button_option1 = $ColorRect/Button2
@onready var button_option2 = $ColorRect/Button3
@onready var timer = $Timer

# Variable to store reference to the player
var player = null

# Hide riddle on start
func _ready():
	riddle_display.visible = false
	label_text.visible = false
	button_correct.visible = false
	button_option1.visible = false
	button_option2.visible = false

# When player enters the collision boundry
func _on_body_entered(body):
	if body.name == "Player":
		player = body
		# Disable player movement
		player.can_move = false
		riddle_display.visible = true
		label_text.visible = true
		button_correct.visible = true
		button_option1.visible = true
		button_option2.visible = true

func _on_button_pressed():
	label_text.text = "Almost, but that is not correct.
	Try again..."

func _on_button_2_pressed():
	label_text.text = "That is not correct. Try again..."
	

func _on_button_3_pressed():
	label_text.text = "Bravo! That is correct!"
	timer.start(2)
	await timer.timeout
	# Enable player movement
	if player != null:
		player.can_move = true
	player = null
	queue_free()
