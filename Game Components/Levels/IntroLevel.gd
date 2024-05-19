# IntroLevel.gd
extends Node2D

@onready var start_game_button = $StartButton
@onready var instructions_button = $InstructionsButton
@onready var our_player = $AnimatedSprite2D
@onready var planet_earth = $Planet
@onready var level_sound = $AudioStreamPlayer2D
@onready var sound_button = $SoundButton

var song = preload("res://Assets/Sounds/Lhomme_Manete_-_Moving_Boulder.mp3")
var is_sound_on := true

func play_level_sound():
	level_sound.stream = song
	level_sound.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	planet_earth.play("PlanetEarth")
	our_player.play("ready")
	play_level_sound()


# Start button functionality 
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Game Components/Levels/level_1.tscn")


# Instructions button functionality
func _on_instructions_button_pressed():
		get_tree().change_scene_to_file("res://Game Components/Levels/instructions.tscn")


# Sound button functionality


func _on_sound_button_pressed():
	is_sound_on = not is_sound_on
	if is_sound_on:
		$AudioStreamPlayer2D.play()
		sound_button.text = "Sound: On"
	else:
		$AudioStreamPlayer2D.stop()
		sound_button.text = "Sound: Off"
