class_name MainMenu
extends PanelContainer

signal button_click

enum ButtonClicked {
	PlayervPlayer = 0,
	PlayervCpu
}

func _ready() -> void:
	%BtnPlayervPlayer.connect("button_down", _on_player_v_player)
	%BtnPlayervCPU.connect("button_down", _on_player_v_cpu)
	
	
func _on_player_v_player() -> void:
	emit_signal("button_click", ButtonClicked.PlayervPlayer)

func _on_player_v_cpu() -> void:
	emit_signal("button_click", ButtonClicked.PlayervCpu)
