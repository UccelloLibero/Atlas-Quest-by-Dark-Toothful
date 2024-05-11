# level_3.gd
extends Node2D

func _on_change_scene_body_entered(body):
	get_tree().change_scene_to_file("res://Game Components/Levels/level_1.tscn")
