class_name Document
extends Control

var deck : Editor.Deck
var slide_index : int = 0
var slide : Editor.Slide:
	get(): return deck.slides[slide_index]
	set(value): return 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shp = Shape.new()
	shp.shape = Shape.Shapes.rounded_rect
	shp.draw(get_node("%Slide Root"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
