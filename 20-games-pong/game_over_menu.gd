class_name GameOverMenu
extends PanelContainer

signal button_clicked

enum ButtonClicked {
	PlayAgain = 0,
	MainMenu
}

func _ready() -> void:
	%BtnPlayAgain.connect("button_down", _on_play_again_clicked)
	%BtnMainMenu.connect("button_down", _on_main_menu_clicked)
	

func _on_play_again_clicked() -> void:
	emit_signal("button_clicked", ButtonClicked.PlayAgain)
	
func _on_main_menu_clicked() -> void:
	emit_signal("button_clicked", ButtonClicked.MainMenu)
