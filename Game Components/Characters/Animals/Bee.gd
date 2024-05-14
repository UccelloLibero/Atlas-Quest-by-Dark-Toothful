# Bee.gd
extends Area2D

@onready var bee_animation = $AnimatedSprite2D
@onready var bee_label = $Label
@onready var timer = $Timer

# Exported variable to adjust the label visibility time
@export var label_duration = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	bee_animation.play("idle")
	# Hide label and timer initially
	bee_label.visible = false
	timer.one_shot = true
	timer.wait_time = label_duration
	


# Show label when the player enters the Bee area
func _on_body_entered(body):
	if body.name == "Player":
		bee_label.visible = true
		timer.start()


# Hide label when the player exits the Bee Area
func _on_body_exited(body):
	if body.name == "Player":
		timer.stop() # Stop timer to avoid automatic hiding
		bee_label.visible = false
		
# Hide the label when the timer times out
func _on_timer_timeout():
	bee_label.visible = false
