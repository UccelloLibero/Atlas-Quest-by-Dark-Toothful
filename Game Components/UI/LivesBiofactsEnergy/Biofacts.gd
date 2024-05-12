# Biofacts.gd
extends ColorRect

# Refernce to label node
@onready var label = $Label

# Update label when text with signal is emited
func update_biofacts(biofacts):
	label.text = str(biofacts)
