class_name GameOverMenu
extends PanelContainer

signal button_clicked

enum ButtonClicked {
	Retry = 0,
	MainMenu
}

func _ready() -> void:
	%BtnRetry.connect("button_down", _on_retry_clicked)
	%BtnMainMenu.connect("button_down", _on_main_menu_clicked)
	

func _on_retry_clicked() -> void:
	emit_signal("button_clicked", ButtonClicked.Retry)
	
func _on_main_menu_clicked() -> void:
	emit_signal("button_clicked", ButtonClicked.MainMenu)
