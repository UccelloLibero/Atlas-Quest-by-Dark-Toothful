# Ladder.gd
extends Area2D

# Function that sets is_climbing to true to stimilate player climbing
func _on_body_entered(body):
	if body.name == "Player":
		Global.is_climbing = true

# Function that sets is_climbing to false to stop climbing
func _on_body_exited(body):
	if body.name == "Player":
		Global.is_climbing = true
