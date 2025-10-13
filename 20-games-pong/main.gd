extends Node2D

## TODO: Scores

enum State {
	PLAYING = 0,
	SCORED,
	GAME_OVER,
	MAIN_MENU,
	PAUSE
}

@onready var state = State.MAIN_MENU

func _ready() -> void:
	%PongCourt.player_scored.connect(_on_player_scored)
	

func _on_player_scored(player: String) -> void:
	
	print(player)
	%Ball.reset_position()
	# Ball move to initial position and make dit invisible
	# Increase Score.
	# If Game Over Show Game Over Screen
