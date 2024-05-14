# When you add at the top of a script the tool keyword, 
# it will be executed not only during the game, 
# but also in the editor.
@tool

# Energy.gd
extends Area2D

# Energy enum
@export var fruit : Global.Energy

# Texture assest for fruit
var apple_texture = preload("res://Assets/Collectibles/LivesAndBiofactAndFruit/apple.png")
var bananas_texture = preload("res://Assets/Collectibles/LivesAndBiofactAndFruit/banana.png")
var cherries_texture = preload("res://Assets/Collectibles/LivesAndBiofactAndFruit/cherry.png")
var pineapple_texture = preload("res://Assets/Collectibles/LivesAndBiofactAndFruit/pineapple.png")
var straberry_texture = preload("res://Assets/Collectibles/LivesAndBiofactAndFruit/strawberry.png")

@onready var fruit_texture = $Sprite2D
@onready var collected_effect = $Effect
@onready var collected_sound = $AudioStreamPlayer2D

# Remove energy from the game scene
func _on_body_entered(body):
	if body.name == "Player":
		## Play collected effect
		#collected_effect.play()
		# Play collected sound
		collected_sound.play()
		# Clear from screen
		#get_tree().queue_delete(self)
		# Add energy to player to update enery statistics
		body.add_energy(fruit)
		queue_free()

# Allows to change sprite texture in editor
func _process(delta):
	if Engine.is_editor_hint():
		if fruit == Global.Energy.APPLE:
			fruit_texture.set_texture(apple_texture)
		elif fruit == Global.Energy.BANANAS:
			fruit_texture.set_texture(bananas_texture)
		elif fruit == Global.Energy.CHERRIES:
			fruit_texture.set_texture(cherries_texture)
		elif fruit == Global.Energy.PINEAPPLE:
			fruit_texture.set_texture(pineapple_texture)
		elif fruit == Global.Energy.STRAWBERRY:
			fruit_texture.set_texture(straberry_texture)
		
		

# Change sprite texture in game scene
func _ready():
	if fruit == Global.Energy.APPLE:
		fruit_texture.set_texture(apple_texture)
	elif fruit == Global.Energy.BANANAS:
		fruit_texture.set_texture(bananas_texture)
	elif fruit == Global.Energy.CHERRIES:
		fruit_texture.set_texture(cherries_texture)
	elif fruit == Global.Energy.PINEAPPLE:
		fruit_texture.set_texture(pineapple_texture)
	elif fruit == Global.Energy.STRAWBERRY:
		fruit_texture.set_texture(straberry_texture)
