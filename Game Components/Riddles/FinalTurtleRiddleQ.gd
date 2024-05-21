# FinalBeeRiddleQ.gd
extends Area2D

@onready var riddle_display = $ColorRect
@onready var label_text = $ColorRect/Label
@onready var button_option0 = $ColorRect/Button
@onready var button_option1 = $ColorRect/Button2
@onready var button_option2 = $ColorRect/Button3
@onready var button_option3 = $ColorRect/Button4
@onready var timer = $Timer

# Correct answer index
@export var correct_answer = 3

# Hide riddle on start
func _ready():
	riddle_display.visible = false
	label_text.visible = false
	button_option0.visible = false
	button_option1.visible = false
	button_option2.visible = false
	button_option3.visible = false

# When player enters the collision boundry
func _on_body_entered(body):
	if body.name == "Player":
		riddle_display.visible = true
		label_text.visible = true
		button_option0.visible = true
		button_option1.visible = true
		button_option2.visible = true
		button_option3.visible = true

func _on_button_pressed():
	label_text.text = "That is not correct. Try again."

func _on_button_2_pressed():
	label_text.text = "That is not correct. Try again."
	

func _on_button_3_pressed():
	label_text.text = "That is correct!"
	timer.start(3)
	await timer.timeout
	queue_free()

func _on_button_4_pressed():
	label_text.text = "That is not correct. Try again."
