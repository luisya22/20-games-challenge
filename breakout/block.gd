class_name Block
extends StaticBody2D

@export var color: Color = Color.WHITE

func _ready() -> void:
	modulate = color
