# Ladder.gd
extends Area2D

@onready var climb_ladder_sound = $AudioStreamPlayer2D

var climbing = preload("res://Assets/Sounds/ladder.mp3")

# Function that sets is_climbing to true to stimilate player climbing
func _on_body_entered(body):
	if body.name == "Player":
		Global.is_climbing = true
		climb_ladder_sound.stream = climbing
		climb_ladder_sound.play()

# Function that sets is_climbing to false to stop climbing
func _on_body_exited(body):
	if body.name == "Player":
		Global.is_climbing = false
		
