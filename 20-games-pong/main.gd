extends Node2D

## TODO: Scores

enum State {
	PLAYING = 0,
	SCORED,
	GAME_OVER,
	MAIN_MENU,
	PAUSE
}

var player1_score = 0
var player2_score = 0

@onready var state = State.MAIN_MENU

func _ready() -> void:
	%PongCourt.player_scored.connect(_on_player_scored)
	

func change_state(state: State) -> void:
	match state:
		State.GAME_OVER:
			%GameOverMenu.visible = true
		_:
			pass

func _on_player_scored(player: String) -> void:
	# Ball move to initial position and make dit invisible
	%Ball.reset_position()
	
	# Increase Score
	if player == "1":
		player1_score += 1
		%Player1Score.text = str(player1_score)
	elif player == "2":
		player2_score  += 1
		%Player2Score.text = str(player2_score)
	
	%Ball.set_direction(player)

	# If Game Over Show Game Over Screen
	if player1_score == 11 && player1_score > player2_score + 1:
		change_state(State.GAME_OVER)
	elif player2_score == 11 && player2_score > player2_score + 1:
		change_state(State.GAME_OVER)
		
	# If Game is not over yet, throw the ball
	%Ball.serve_ball()
	
	# Reset the players
	%Player.reset_position()
	%Player2.reset_position()
