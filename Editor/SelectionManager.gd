class_name SelectionManager
extends RefCounted

signal selection_changed(selected: Array[Editor.SlideObject])

var selected: Array[Editor.SlideObject] = []

func select(obj: Editor.SlideObject, additive: bool = false) -> void:
	if not additive:
		selected.clear()
	if obj not in selected:
		selected.append(obj)
	selection_changed.emit(selected)

func deselect_all() -> void:
	selected.clear()
	selection_changed.emit(selected)

func is_selected(obj: Editor.SlideObject) -> bool:
	return obj in selected
