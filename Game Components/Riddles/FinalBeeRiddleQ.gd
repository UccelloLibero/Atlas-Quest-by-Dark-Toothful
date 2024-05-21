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
	label_text.text = "Yes, honey bees make honey by collecting
	nectar from flowers and converting it into honey.
	The honey is made when bees fan their 
	wings causing evaporation and by that breaking
	down the nectar into simple sugars.
	But that is not the answer we're looking for..."

func _on_button_2_pressed():
	label_text.text = "Yes, honey bees are considered some of the 
	hardest working insects, with some bees working up to 12 
	hours a day, from dawn to dusk.
	But that is not the answer we are looking for."
	

func _on_button_3_pressed():
	label_text.text = "Correct! Bees pollinate our wild trees
	and wild flowers, which then 
	supports other insects, 
	which then supports birds, bats, mammals
	and everything up the food chain with food and shelter."
	timer.start(5)
	await timer.timeout
	# Enable player movement
	if player != null:
		player.can_move = true
	player = null
	queue_free()
