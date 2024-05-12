# Lives.gd
extends ColorRect

# Refernce to label node
@onready var label = $Label

# Update label when text with signal is emited
func update_energy(energy):
	label.text = str(energy)
