# bad_plant.gd
extends Node2D

# Poison scene reference
var poison = preload("res://Game Components/Obstacles/plant_poison.tscn")

# References to the scene, PathFollow2D path, and AnimationPlayer path
var current_scene_path
var poison_path
var poison_animation

# Called when the node enters the scene tree for the first time.
func _ready():
	# default animation on load
	$AnimatedSprite2D.play("idle")
	
	# Initiate paths
	current_scene_path = "/root/" + Global.current_scence_name + "/" # current scene
	poison_path = get_node(current_scene_path + "/PoisonPath/Path2D/PathFollow2D") # PathFollow2D
	poison_animation = get_node(current_scene_path + "/PoisonPath/Path2D/AnimationPlayer") # AnimationPlayer
	
	# Starts poison movement
	poison_animation.play("poison_movement")
# Spanws poinson instance
func shoot():
	# Play bad plant animation each time funcion is fired off
	$AnimatedSprite2D.play("attack")
	# Set the poison ball to moving and plays poision bomb animation
	Global.is_poison_ball_moving = true
	poison_animation.play("poison_movement")
	# Return poison ball
	var spawned_poison = poison.instantiate()
	return spawned_poison
	
	
# Shoot and spawn poision on path
func _on_timer_timeout():
	# Rest animation before shooting
	$AnimatedSprite2D.play("idle")
	# Spawns a poison ball onte the path if there are no poison balls avaliable
	if poison_path.get_child_count() <= 0:
		poison_path.add_child(shoot())
		
	# Clear all existing poison balls
	if Global.is_poison_ball_moving == false:
		for poison in poison_path.get_children():
			poison_path.remove_child(poison)
			poison.queue_free()
			poison_animation.stop()
