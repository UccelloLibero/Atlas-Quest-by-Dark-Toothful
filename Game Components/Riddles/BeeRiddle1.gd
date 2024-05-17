# BeeRiddle1.gd
extends Area2D

@onready var riddle_display = $ColorRect
@onready var label_text = $ColorRect/Label
@onready var timer = $Timer

# Hide riddle on start
func _ready():
	riddle_display.visible = false
	label_text.visible = false

# When player enters the collision boundry
func _on_body_entered(body):
	if body.name == "Player":
		riddle_display.visible = true
		label_text.visible = true



func _on_body_exited(body):
	queue_free()
