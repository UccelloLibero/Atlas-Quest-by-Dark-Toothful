# When you add at the top of a script the tool keyword, 
# it will be executed not only during the game, 
# but also in the editor.
#@tool

# Energy.gd
extends Area2D

# Energy enum
@export var fruit : Global.Energy

# Sound
var collected = preload("res://Assets/Sounds/energypickup.mp3")

#@onready var fruit_texture = $Sprite2D
@onready var collected_effect = $Effect
@onready var collected_sound = $AudioStreamPlayer2D

@onready var fruit_texture = $AnimatedSprite2D



func play_sound():
	collected_sound.stream = collected
	collected_sound.play()
	

# Remove energy from the game scene
func _on_body_entered(body):
	if body.name == "Player":
		play_sound()
		$Effect.play("collected")
		await collected_effect.animation_finished

# Allows to change sprite texture in editor
func _process(delta):
	if Engine.is_editor_hint():
		if fruit == Global.Energy.APPLE:
			$AnimatedSprite2D.play("apple")
		elif fruit == Global.Energy.BANANAS:
			$AnimatedSprite2D.play("bananas")
		elif fruit == Global.Energy.CHERRIES:
			$AnimatedSprite2D.play("cherries")
		elif fruit == Global.Energy.PINEAPPLE:
			$AnimatedSprite2D.play("pineapple")
		elif fruit == Global.Energy.STRAWBERRY:
			$AnimatedSprite2D.play("strawberry")
		
		

# Change sprite texture in game scene
func _ready():
	if fruit == Global.Energy.APPLE:
		$AnimatedSprite2D.play("apple")
	elif fruit == Global.Energy.BANANAS:
		$AnimatedSprite2D.play("bananas")
	elif fruit == Global.Energy.CHERRIES:
		$AnimatedSprite2D.play("cherries")
	elif fruit == Global.Energy.PINEAPPLE:
		$AnimatedSprite2D.play("pineapple")
	elif fruit == Global.Energy.STRAWBERRY:
		$AnimatedSprite2D.play("strawberry")


func _on_body_exited(body):
	#get_tree().queue_delete(self)
	queue_free()
	# Add energy to energy UI
	body.add_energy(fruit)

	
