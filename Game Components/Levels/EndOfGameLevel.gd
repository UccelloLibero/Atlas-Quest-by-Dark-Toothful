# EndOfGameLevel.gd
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
		get_tree().change_scene_to_file("res://Game Components/Levels/level_1.tscn")


func _on_game_over_pressed():
	get_tree().change_scene_to_file("res://Game Components/Levels/intro_level.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Game Components/Levels/Credits_Page.tscn")
