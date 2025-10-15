class_name Ball
extends CharacterBody2D

signal block_hit(block: Block)
signal out_of_bounds

@export var speed_increase_per_bounce = 2

var speed = 200
var initial_speed = 200
@onready var move_dir = Vector2(0, 1)
@onready var initial_position = global_position
@onready var is_moving = false

var paddle_audio = preload("res://assets/paddle_hit.wav")
var block_audio = preload("res://assets/block_hit.wav")
var wall_audio = preload("res://assets/wall_hit.wav")
var failed_audio = preload("res://assets/failed.wav")

func _physics_process(delta: float) -> void:
	if is_moving:
		velocity = move_dir.normalized() * speed
		var collided = move_and_slide()
		
		if collided:
			var collider = get_last_slide_collision().get_collider()
			if collider is Player:
				_handle_paddle_hit(collider)
				%Audio.stream = paddle_audio
				%Audio.play()
			elif collider is Block:
				move_dir.y *= -1
				speed += speed_increase_per_bounce
				_handle_block_hit(collider)
				%Audio.stream = block_audio
				%Audio.play()
			elif collider is BottomWall:
				emit_signal("out_of_bounds")
				%Audio.stream = failed_audio
				%Audio.play()
			else:
				move_dir = move_dir.bounce(get_last_slide_collision().get_normal())
				%Audio.stream = wall_audio
				%Audio.play()
				
		else:
			velocity = Vector2.ZERO
			

func _handle_paddle_hit(body: CharacterBody2D):
	if body is Player:
		var paddle_width = body.get_node("CollisionShape2D").shape.get_rect().size.y
		var new_move_dir_x = (global_position.x - body.global_position.x) / (paddle_width/2.0)
		move_dir.x = new_move_dir_x
		move_dir.y *= -1
		
func _handle_block_hit(body: Block):
	speed += speed_increase_per_bounce
	emit_signal("block_hit", body)
	
func reset_position() -> void:
	global_position = initial_position
	move_dir = Vector2(0, 1)
	is_moving = false

func serve_ball() -> void:
	speed = initial_speed
	is_moving = true
