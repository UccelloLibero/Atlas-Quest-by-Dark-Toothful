# When you add at the top of a script the tool keyword, 
# it will be executed not only during the game, 
# but also in the editor.
@tool

# life_energy.gd
extends Area2D

# life and biofact enum
@export var collect : Global.LifeBiofact


# Sound
var collected = preload("res://Assets/Sounds/biofactpickup.mp3")

# Referece the sprite texture & audio node
@onready var sprite_texture = $AnimatedSprite2D
@onready var collected_sound = $AudioStreamPlayer2D

func play_sound():
	collected_sound.stream = collected
	collected_sound.play()


# Removes life/biofact from the game scene tree
func _on_body_entered(body):
	if body.name == "Player":
		play_sound()


# Allows to change the sprite texture in the editor
func _process(delta):
	if Engine.is_editor_hint():
		if collect == Global.LifeBiofact.LIFE:
			$AnimatedSprite2D.play("life")
		elif collect == Global.LifeBiofact.BIOFACT:
			$AnimatedSprite2D.play("biofact")
			

# Change sprites texture in game scene
func _ready():
	if collect == Global.LifeBiofact.LIFE:
		$AnimatedSprite2D.play("life")
	elif collect == Global.LifeBiofact.BIOFACT:
		$AnimatedSprite2D.play("biofact")
		


func _on_body_exited(body):
	get_tree().queue_delete(self)
	# Add life/biofact to player to change player statistics
	body.add_life_biofact(collect)
