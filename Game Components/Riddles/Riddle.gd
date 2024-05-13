# Riddle
extends Area2D

@onready var riddle_display = $ColorRect
@onready var label_text = $ColorRect/Label
@onready var button_correct = $ColorRect/Button
@onready var button_incorrect = $ColorRect/Button2

# Hide riddle on start
func _ready():
	riddle_display.visible = false
	label_text.visible = false
	button_correct.visible = false
	button_incorrect.visible = false




func _on_body_entered(body):
	if body.name == "Player":
		riddle_display.visible = true
		label_text.visible = true
		button_correct.visible = true
		button_incorrect.visible = true


func _on_body_exited(body):
	queue_free()


func _on_button_pressed():
	label_text.text = "You are correct"
