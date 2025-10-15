extends Node2D

var score = 0
var health = 3
var level = 1

var high_score = 0

var state = State.MAIN_MENU

enum State {
	PLAYING = 0,
	GAME_OVER,
	MAIN_MENU,
	PAUSE,
	START_GAME
}

func _ready() -> void:
	%Ball.block_hit.connect(_on_block_hit)
	%Ball.out_of_bounds.connect(_on_out_of_bounds)
	
	%MainMenu.button_clicked.connect(_on_main_menu_button_clicked)
	%GameOverMenu.button_clicked.connect(_on_game_over_menu_button_clicked)
	
func _process(delta: float) -> void:
	%ScoreLabel.text = "Score " + str(score)
	%HealthLabel.text = "Health " + str(health)
	%LevelLabel.text = "Level " + str(level)

func change_state(state: State) -> void:
	self.state = state
	match state:
		State.GAME_OVER:
			%GameOverMenu.visible = true
			if score > high_score:
				high_score = score
				%HSMainMenuLabel.text = "High Score: " + str(high_score)
				%HSGameOverLabel.text = "High Score: " + str(high_score)
		State.START_GAME:
			_start_game()
			%MainMenu.visible = false
			%GameOverMenu.visible = false
		State.MAIN_MENU:
			%MainMenu.visible = true
			%GameOverMenu.visible = false
		_:
			pass

func _on_block_hit(block: Block):
	block.visible = false
	block.get_node("CollisionShape2D").disabled = true
	score += 1

func _on_out_of_bounds():
	%Ball.reset_position()
	health -= 1
	
	if health == 0:
		change_state(State.GAME_OVER)
		return
	
	await get_tree().create_timer(2).timeout
	%Ball.serve_ball()

func _start_game() -> void:
	score = 0
	health = 3
	%Player.restart_position()
	for block in %Blocks.get_children():
		block.visible = true
		block.get_node("CollisionShape2D").disabled = false
	
	await get_tree().create_timer(1).timeout
	%Ball.serve_ball()

func _on_main_menu_button_clicked(button_clicked: MainMenu.ButtonClicked) -> void:
	match button_clicked:
		MainMenu.ButtonClicked.Start:
			change_state(State.START_GAME)
		_:
			pass

func _on_game_over_menu_button_clicked(button_clicked: GameOverMenu.ButtonClicked) -> void:
	match button_clicked:
		GameOverMenu.ButtonClicked.Retry:
			change_state(State.START_GAME)
		GameOverMenu.ButtonClicked.MainMenu:
			change_state(State.MAIN_MENU)
