# Apple.gd
extends Area2D

# Reference animatons for the apple 
@onready var apple_animation = $AnimatedSprite2D
@onready var picked_up_sound = $AudioStreamPlayer2D

# To play animation for apple in the sccene
func _ready():
	apple_animation.play("eatme")

# To handle collected feedback - visual and sound only for now
func _on_body_entered(body):
	if body.name == "Player":
		apple_animation.play("collected")
		picked_up_sound.play()
		await apple_animation.animation_finished
		queue_free()

