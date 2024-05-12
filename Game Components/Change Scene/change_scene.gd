# change_scene.gd
extends Area2D

@onready var door_animation = $AnimatedSprite2D
@onready var play_door_sound = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	door_animation.play("walk_in")
	
	
