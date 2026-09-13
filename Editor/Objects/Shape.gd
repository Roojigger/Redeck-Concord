class_name Shape
extends Editor.SlideObject

var shape    : Shapes
var fill_col : Color

var factor : float = .5 # controls shapes specsific factor, such as corner rounding, should be [0-1]

enum Shapes {
	rectangle,
	ellipse,
	rounded_rect,
}

var _node_ref : Polygon2D

func draw(screen : Node2D) -> void:
	if not _node_ref:
		_node_ref = Polygon2D.new()
		screen.add_child(_node_ref)
	
	_node_ref.position = rect.position
	
	_node_ref.color = fill_col
	
	var points : PackedVector2Array = PackedVector2Array()
	
	var res = 32
	match shape:
		Shapes.rectangle: 
			points.append(Vector2(0,          0          ))
			points.append(Vector2(rect.size.x,0          ))
			points.append(Vector2(rect.size.x,rect.size.y))
			points.append(Vector2(0,          rect.size.y))
		Shapes.ellipse: 
			for i in range(res):
				var theta = i / float(res) * 2*PI
				points.append(Vector2.from_angle(theta)*Vector2(rect.size))
		Shapes.rounded_rect:
			# radius in real pixels, capped so it can't exceed half the shorter side
			var radius = clamp(factor, 0.0, 1.0) * 0.5 * min(rect.size.x, rect.size.y)

			var corners = [
				Vector2(radius, radius),
				Vector2(rect.size.x - radius, radius),
				Vector2(rect.size.x - radius, rect.size.y - radius),
				Vector2(radius, rect.size.y - radius),
			]
			var start_angles = [PI, -PI/2, 0.0, PI/2]

			for i in range(4):
				for s in range(res + 1):
					var angle = start_angles[i] + (float(s) / res) * (PI / 2)
					points.append(corners[i] + Vector2(cos(angle), sin(angle)) * radius)

		
		_ : assert(false, "Shape: {}, not in Shapes".format(shape))
	
	_node_ref.polygon = points;
	
