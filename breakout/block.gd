class_name Block
extends StaticBody2D

@export var row: int = 1

var colors: Array = [
	Color.WHITE,
	Color("#1E90FF"), # Blue
	Color("#00CC66"), # Green
	Color("#FFD700"), # Yellow
	Color("#FF8C00"), # Orange
	Color("#FF4500"), # Red-orange
	Color("#C71585"), # Magenta
	Color("#ADFF2F")  # Lime
]

func _ready() -> void:
	modulate = colors[row]
