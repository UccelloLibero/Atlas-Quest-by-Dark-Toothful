# Plant_poison.gd
extends Area2D

var rotation_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spit poison ball
	$AnimatedSprite2D.play("moving")

func _on_body_entered(body):
	# If the plant poison ball collides wiht the player, play burst animation
	if body.name == "Player":
		$AnimatedSprite2D.play("burst")
		$Timer.start()
		Global.is_poison_ball_moving = false
		# Give damage
		body.take_damage()
			
	# If the plant poison ball colides with the tilemap 
	if body.name == "TileMap":
		$AnimatedSprite2D.play("burst")
		$Timer.start()
		Global.is_poison_ball_moving = false


# Revmove the poison ball from the scene only if poison ball is present
func _on_timer_timeout():
	if is_instance_valid(self):
		self.queue_free()
		
# Rolls the poison ball
func _physics_process(delta):
	# Rotate poison ball if it hasn't bursted
	if Global.is_poison_ball_moving == true:
		$AnimatedSprite2D.rotation += rotation_speed * delta
