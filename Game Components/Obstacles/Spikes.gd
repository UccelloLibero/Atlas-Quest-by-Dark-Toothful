extends Node2D

@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.take_damage()
		timer.start(5)
		await timer.timeout
		


func _on_area_2d_body_exited(body):
	pass
	#body = null
	




