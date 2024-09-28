extends Area2D

@onready var panel = $Panel  # Assuming Panel is a child of the Area2D node
@onready var start_level_button = $Panel/StartLevelButton  # Path to the start level button

func _ready():
	panel.visible = false  # Hide the panel initially
	start_level_button.connect("pressed", Callable(self, "_on_start_level_button_pressed"))
	connect("input_event", Callable(self, "_on_input_event"))
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		panel.visible = true  # Show the panel when the icon is pressed

func _on_mouse_entered():
	panel.visible = true  # Show the panel when the mouse enters the collision area

func _on_mouse_exited():
	panel.visible = false  # Hide the panel when the mouse exits the collision area
	
func _on_start_level_button_pressed():
	get_tree().change_scene_to_file("res://Game Components/Levels/level_3.tscn")
