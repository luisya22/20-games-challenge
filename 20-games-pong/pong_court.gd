class_name PongCourt
extends StaticBody2D

signal player_scored(player: String)

func _ready() -> void:
	%LeftGoal.ball_hit.connect(_on_ball_hit)
	%RightGoal.ball_hit.connect(_on_ball_hit)

func _on_ball_hit(player: String) -> void:
	emit_signal("player_scored", player)
