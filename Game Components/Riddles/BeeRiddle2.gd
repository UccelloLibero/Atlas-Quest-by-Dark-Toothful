# BeeRiddle2.gd
extends Area2D

# Reference nodes of BeeRiddle1 scene
@onready var riddle_display = $ColorRect
@onready var label_text = $ColorRect/Label
@onready var timer = $Timer

# Exported variable to set duration of label visibility
@export var label_duration = 8.0

# Hide riddle on start
func _ready():
	riddle_display.visible = false
	label_text.visible = false
	$Timer.one_shot = true
	$Timer.wait_time = label_duration

# When player enters the collision boundry
func _on_body_entered(body):
	if body.name == "Player":
		riddle_display.visible = true
		label_text.visible = true
		$Timer.start()
		

# After timer times out, clear the scene of the ColorRect and label
func _on_timer_timeout():
	queue_free()
