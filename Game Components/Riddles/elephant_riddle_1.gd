# elepahnt_riddle_1.gd
extends Area2D

@onready var riddle_display = $ColorRect
@onready var label_text = $ColorRect/Label
@onready var button_correct = $ColorRect/Button
@onready var button_option1 = $ColorRect/Button2
@onready var button_option2 = $ColorRect/Button3
@onready var timer = $Timer

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
		riddle_display.visible = true
		label_text.visible = true
		button_correct.visible = true
		button_option1.visible = true
		button_option2.visible = true

func _on_button_pressed():
	label_text.text = "That is incorect. 
	They fly much faster!
	Try again!"


func _on_button_2_pressed():
	label_text.text = "Correct! When foraging, worker bees can fly up to 
	20mP or 32 KMP, beating their wings 200 times a second. This
	creates the iconic 'bzzz' sound."
	timer.start(7)
	await timer.timeout
	queue_free()


func _on_button_3_pressed():
	label_text.text = "That is incorect. 
	They are fast but not that fast!
	Try again!"
