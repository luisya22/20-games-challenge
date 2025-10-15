class_name MainMenu
extends PanelContainer

signal button_clicked

enum ButtonClicked {
	Start = 0,
}

func _ready() -> void:
	%BtnStart.connect("button_down", _on_start_clicked)
	
func _on_start_clicked() -> void:
	emit_signal("button_clicked", ButtonClicked.Start)
	print("Button Start Clicked")
