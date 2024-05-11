extends RigidBody2D

# Refer to the destruction scene of th object
@onready var _bad_plant_animation = $Plant
# Refer to the animated sprite effets of destruction
@onready var _bad_plant_animation_effects = $PlantEffects

# Define the BadPlant
var new_bad_plant = RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spit poison ball
	_bad_plant_animation.play("attack")

	

