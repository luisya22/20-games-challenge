extends Area2D

signal ball_hit(player_goal: String)

@export var player_goal: String = "1"

func _ready() -> void:
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		emit_signal("ball_hit", player_goal)
