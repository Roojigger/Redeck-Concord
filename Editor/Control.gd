extends Control 

@onready var slide_root: Node2D = $%"Slide Root"
@onready var document: Control = $"/root/Editor"
@onready var selection : SelectionManager = SelectionManager.new()

var zoom: float = 1.0
var min_zoom: float = 0.1
var max_zoom: float = 8.0

var panning: bool = false
var pan_last_mouse: Vector2

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_zoom_at(1.1, event.position)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_zoom_at(1.0 / 1.1, event.position)
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			panning = event.pressed
			pan_last_mouse = event.position
		elif event.button_index == MOUSE_BUTTON_LEFT:
			_try_select_at(event.position)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			handle_rmb(event)

	elif event is InputEventMouseMotion and panning:
		var delta = event.position - pan_last_mouse
		slide_root.position += delta
		pan_last_mouse = event.position

func _zoom_at(factor: float, screen_point: Vector2) -> void:
	var new_zoom = clamp(zoom * factor, min_zoom, max_zoom)
	factor = new_zoom / zoom  # actual applied factor after clamping
	zoom = new_zoom

	# Keep the point under the cursor fixed in place while zooming
	var local_point = screen_point - slide_root.position
	slide_root.position -= local_point * (factor - 1.0)
	slide_root.scale *= factor


func _try_select_at(screen_point: Vector2) -> void:
	var local_point = slide_root.to_local(screen_point)
	var hit: Editor.SlideObject = null
	for obj in document.slide.get_objects_reversed():
		if obj.rect.has_point(local_point):
			hit = obj
			break
	if hit:
		selection.select(hit, Input.is_key_pressed(KEY_SHIFT))
	else:
		selection.deselect_all()

func  handle_rmb(event):
	pass
