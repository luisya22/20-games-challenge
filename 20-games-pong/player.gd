class_name Player
extends CharacterBody2D

const SPEED = 50
var acceleration = 50.0
const MAX_VELOCITY = 10.0
const SLOW_DOWN_DELTA = 2.0
@export var top = 56
@export var down = 312
@export var player = "1"
var up_input = "paddle_up"
var down_input = "paddle_down"
var playing = false
var is_player = true
@export var ball: Ball
@export var oponent: Player
var cpu_direction: Vector2

@onready var initial_position = global_position

func _ready() -> void:
	if player == "2":
		up_input += "_two"
		down_input += "_two"

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if playing && is_player:
		if Input.is_action_pressed(up_input):
			direction.y -= 1
		if Input.is_action_pressed(down_input):
			direction.y += 1
	else:
		direction = cpu_direction
		
	velocity += direction * SPEED * delta
	if direction.y == 0.0:
		velocity.y = move_toward(velocity.y, 0.0, SLOW_DOWN_DELTA)
		
	velocity.y = clampf(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)
	
	global_position.y += velocity.y
	global_position.y = clampf(global_position.y, top, down)

func reset_position() -> void:
	global_position = initial_position

func start_playing() -> void:
	playing = true
	if not is_player:
		%AIBehaviorManager.is_cpu = true
		%AIBehaviorManager.ball = self.ball
		print("Is CPU")

func stop_playing () -> void:
	playing = false
	reset_position()

func set_cpu() -> void:
	is_player = false
