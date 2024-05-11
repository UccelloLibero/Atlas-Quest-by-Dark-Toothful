extends RigidBody2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("idle")

