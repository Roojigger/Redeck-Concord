extends Control

var deck : Editor.Deck
var slide_index : int = 0
var slide : Editor.Slide:
	get(): return deck.slides[slide_index] if (deck and slide_index < len(deck.slides)) else null
	set(value): return 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not deck:
		deck = Editor.Deck.new()
		deck.slides = [Editor.Slide.new()]
		
		var rrect = Shape.new()
		rrect.shape = Shape.Shapes.rounded_rect
		rrect.rect = Rect2i(-32,-32,64,64)
		
		slide.objects.append(rrect)
		
		slide.draw(%"Slide Root")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
