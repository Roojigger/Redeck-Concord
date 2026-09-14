class_name Editor

@abstract class SlideObject: # abstract base class for all objects e.g shape, image, textbox
	var z_index  : int    = 0
	var rect     : Rect2i = Rect2i(0,0,32,32)
	var rotation : float  = 0
	
	var outline  : Outline
	
	class Outline:
		var width : int   = 0
		var color : Color = Color.TRANSPARENT
	
	@abstract func draw(screen : Node2D) -> void

class Slide:
	var objects : Array[SlideObject]
	
	func draw(root_node):
		for object in objects:
			object.draw(root_node)
	
	func get_objects_reversed() -> Array[SlideObject]:
		"""Returns all objects sorted by inverse z_index"""
		var sorted = objects
		sorted.sort_custom(func(a,b): return a.z_index < a.z_index)
		return sorted

class Deck:
	var slides : Array[Slide]
