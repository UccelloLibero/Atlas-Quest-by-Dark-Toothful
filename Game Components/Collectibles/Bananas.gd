# Bananas.gd
extends Area2D

# Reference animatons for the apple 
@onready var bananas_animation = $AnimatedSprite2D
@onready var picked_up_sound = $AudioStreamPlayer2D

# To play animation for apple in the sccene
func _ready():
	bananas_animation.play("eatme")



func _on_body_entered(body):
	if body.name == "Player":
		bananas_animation.play("collected")
		picked_up_sound.play()
		await bananas_animation.animation_finished
		queue_free()
