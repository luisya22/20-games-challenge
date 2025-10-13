extends Node2D

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

# TODO: Make buttons work, start with the Main Menu state, do CPU AI, Sound

func _ready() -> void:
	%PongCourt.player_scored.connect(_on_player_scored)
	%MainMenu.button_click.connect(_on_main_menu_button_clicked)

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
		%GameOverLabel.text = "Player 1 Won!" # Change it to You Won! if it's against CPU
		%GameOverMenu.visible = true
		return
	elif player2_score == 11 && player2_score > player2_score + 1:
		change_state(State.GAME_OVER)
		%GameOverMenu.visible = true
		%GameOverLabel.text = "Player 2 Won!"  # Change to you lost if it's against CPU
		return
		
	# If Game is not over yet, throw the ball
	%Ball.serve_ball()
	
	# Reset the players
	%Player.reset_position()
	%Player2.reset_position()

func _on_main_menu_button_clicked(button_clicked: MainMenu.ButtonClicked) -> void:
	match button_clicked:
		MainMenu.ButtonClicked.PlayervPlayer:
			print("player_v_player")
			_start_game()
		MainMenu.ButtonClicked.PlayervCpu:
			print("player_v_cpu")
			%Playe2.set_cpu()
			_start_game()
		_:
			pass

func _start_game() -> void:
	%Player.start_playing()
	%Player2.start_playing()
	%Ball.serve_ball()
	
	%MainMenu.visible = false
	
