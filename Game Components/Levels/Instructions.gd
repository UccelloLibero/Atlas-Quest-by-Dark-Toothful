# Instructions.gd
extends Node2D

# Reference main menu button
@onready var main_menu_button = $Button

# Reference audio
@onready var level_sound = $AudioStreamPlayer2D

# Variable to hold level sond
var song = preload("res://Assets/Sounds/Lhomme_Manete_-_Moving_Boulder.mp3")


func _ready():
	level_sound.stream = song
	level_sound.play()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Game Components/Levels/intro_level.tscn")
