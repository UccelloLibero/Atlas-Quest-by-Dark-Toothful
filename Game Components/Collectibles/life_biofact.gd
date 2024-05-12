# When you add at the top of a script the tool keyword, 
# it will be executed not only during the game, 
# but also in the editor.
@tool

# life_energy.gd
extends Area2D

# life and biofact enum
@export var collect : Global.LifeBiofact

# Texture assets for life and biofact
var life_texture = preload("res://Assets/Collectibles/LivesAndBiofactAndFruit/sprite_4.png")
var biofact_texture = preload("res://Assets/Collectibles/LivesAndBiofactAndFruit/08.png")

# Referece the sprite texture
@onready var sprite_texture = get_node("Sprite2D")


# Removes life/biofact from the game scene tree
func _on_body_entered(body):
	if body.name == "Player":
		get_tree().queue_delete(self)
		# Add life/biofact to player to change player statistics
		body.add_life_biofact(collect)


# Allows to change the sprite texture in the editor
func _process(delta):
	if Engine.is_editor_hint():
		if collect == Global.LifeBiofact.LIFE:
			sprite_texture.set_texture(life_texture)
		elif collect == Global.LifeBiofact.BIOFACT:
			sprite_texture.set_texture(biofact_texture)
			

# Change sprites texture in game scene
func _ready():
	if collect == Global.LifeBiofact.LIFE:
		sprite_texture.set_texture(life_texture)
	elif collect == Global.LifeBiofact.BIOFACT:
		sprite_texture.set_texture(biofact_texture)
		
