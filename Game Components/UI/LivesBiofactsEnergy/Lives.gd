# Lives.gd
extends ColorRect

# Refernce to label node
@onready var label = $Label

# Update label when text with signal is emited
func update_lives(lives, max_lives):
	label.text = str(lives)
