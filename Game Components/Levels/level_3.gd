# level_3.gd
extends Node2D

@onready var level_sound = $AudioStreamPlayer2D

var song = preload("res://Assets/Sounds/Lhomme_Manete_-_Out_of_the_Cave.mp3")

func _ready():
	level_sound.stream = song
	level_sound.play()

#func _on_change_scene_body_entered(body):
	#get_tree().change_scene_to_file("res://Game Components/Levels/end_of_game_level.tscn")


func _on_finished_level_body_entered(body):
	get_tree().change_scene_to_file("res://Game Components/Levels/end_of_game_level.tscn")
