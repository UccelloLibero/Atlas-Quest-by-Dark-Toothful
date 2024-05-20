extends CharacterBody2D

const IDLE_ANIMATION = "idle"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play(IDLE_ANIMATION)


# Get elephant ready to follow the player
@export var follow_speed := 150
@onready var player: CharacterBody2D = null
var is_following := false
@export var offset := Vector2(-50, 0)


func _process(delta):
	if is_following and player:
		# Calculate the target position with the offset
		var target_x_position = player.position.x + offset.x
		# Move towards player
		position.x = position.move_toward(Vector2(target_x_position, position.y), follow_speed * delta).x
		

func _on_area_2d_body_entered(body):
	if body.name == "Player" and body is CharacterBody2D:
		is_following = true
		player = body


func _on_area_2d_body_exited(body):
		if body.name == "Player" and body is CharacterBody2D:
			is_following = true
			player = body
