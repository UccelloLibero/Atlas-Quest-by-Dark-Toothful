# change_scene.gd
extends Area2D

@onready var door_animation = $AnimatedSprite2D
@onready var play_door_sound = $AudioStreamPlayer2D

var door_sound = preload("res://Assets/Sounds/nextlevel.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	door_animation.play("walk_in")
	
func play_next_level():
	play_door_sound.stream = door_sound
	play_door_sound.play()
	

func _on_body_entered(body):
	play_next_level()
