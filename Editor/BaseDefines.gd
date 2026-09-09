class_name Editor
extends Object

class SlideObject: # base class for all objects e.g shape, image, textbox
	var z_index  : int
	var rect     : Rect2i
	var rotation : float

class Slide:
	var objects : Array[SlideObject]

class Deck:
	var slides : Array[Slide]
