# Introlevel.gd
extends Node2D

@onready var start_game_button = $Button
@onready var our_player = $AnimatedSprite2D
@onready var planet_earth = $Planet


# Called when the node enters the scene tree for the first time.
func _ready():
	planet_earth.play("PlanetEarth")
	our_player.play("ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Game Components/Levels/level_1.tscn")
