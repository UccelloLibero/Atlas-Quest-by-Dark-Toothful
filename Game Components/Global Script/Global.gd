# Global.gd
extends Node


# Movement states
var is_attacking = false
var is_climbing = false
var is_jumping = false

# Current scene
var current_scence_name

# Poison ball movement state
var is_poison_ball_moving = false

# Life heart and biofact envelope
enum LifeBiofact {LIFE, BIOFACT}

# Energy fruit
enum Energy {APPLE, BANANAS, CHERRIES, PINEAPPLE, STRAWBERRY}

func _ready():
	# Sets the current scene"s name
	current_scence_name = get_tree().get_current_scene().name

# Number of attacks for poacher
var number_attack = 0
# Type of attack applied
var attack_effect = "normal"

