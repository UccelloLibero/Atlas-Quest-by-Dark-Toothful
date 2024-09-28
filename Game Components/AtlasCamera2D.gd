extends Camera2D

var zoom_factor = 0.1
var min_zoom = Vector2(0.5, 0.5)
var max_zoom = Vector2(2, 2)

func _ready():
	zoom = Vector2(1, 1)  # Initial zoom level

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_out()

func zoom_in():
	zoom -= Vector2(zoom_factor, zoom_factor)
	if zoom.x < min_zoom.x:
		zoom = min_zoom

func zoom_out():
	zoom += Vector2(zoom_factor, zoom_factor)
	if zoom.x > max_zoom.x:
		zoom = max_zoom
