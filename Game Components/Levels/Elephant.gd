extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const IDLE_ANIMATION = "idle"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	animated_sprite.play(IDLE_ANIMATION)
