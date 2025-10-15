class_name Player
extends CharacterBody2D

const SPEED = 500
var playing = true
@export var left = 33
@export var right = 607

@onready var initial_position = global_position

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if playing:
		if Input.is_action_pressed("paddle_left"):
			direction.x = -1
		if Input.is_action_pressed("paddle_right"):
			direction.x = 1
			
	velocity = direction * SPEED * delta
	if direction.x == 0.0:
		velocity = Vector2.ZERO
		
	global_position.x += velocity.x
	global_position.x = clampf(global_position.x, left, right)

func restart_position() -> void:
	global_position = initial_position
