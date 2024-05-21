# ElephantFact2.gd
extends Area2D

@onready var ElephantFact1_animation = $AnimatedSprite2D
@onready var ElephantFact1_colorRect = $ColorRect
@onready var ElephantFact1_label = $ColorRect/Label
@onready var timer = $Timer
@onready var collected_sound = $AudioStreamPlayer2D

# Exported variable to adjust the label visibility time
@export var label_duration = 7.0

# Variable to store reference to the player
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	ElephantFact1_animation.play("idle")
	# Hide label and timer initially
	ElephantFact1_colorRect.visible = false
	ElephantFact1_label.visible = false
	timer.one_shot = true
	timer.wait_time = label_duration
	
# Show label when the player enters the Fact area
func _on_body_entered(body):
	if body.name == "Player":
		player = body
		player.can_move = false
		ElephantFact1_colorRect.visible = true
		ElephantFact1_label.visible = true
		timer.start()
		
# Hide the label when the timer times out
func _on_timer_timeout():
	ElephantFact1_colorRect.visible = false
	ElephantFact1_label.visible = false
	# Enable player movement
	if player != null:
		player.can_move = true
	player = null
	queue_free()

