class_name Ball
extends CharacterBody2D

@export var speed_increase_per_bounce = 20
var speed = 100
var initial_speed = 100
var move_dir = Vector2(-1, 0)
@onready var initial_position = global_position
@onready var is_moving = false

func _ready() -> void:
	var random_direction = get_random_direction()
	move_dir = Vector2(random_direction, 0)

func _physics_process(delta: float) -> void:
	if is_moving:
		velocity = move_dir * speed
		var collided = move_and_slide()
	
		if collided:
			var collider = get_last_slide_collision().get_collider()
			if collider.is_in_group("paddle"):
				_handle_paddle_hit(collider)
			else:
				move_dir = move_dir.bounce(get_last_slide_collision().get_normal())
	else:
		velocity = Vector2.ZERO

func _handle_paddle_hit(body: CharacterBody2D):
	if body.is_in_group("paddle"):
		var paddle_height = body.get_node("CollisionShape2D").shape.get_rect().size.y
		var new_move_dir_y = (global_position.y - body.global_position.y) / (paddle_height/2.0)
		move_dir.y = new_move_dir_y
		move_dir.x *= -1
		speed += speed_increase_per_bounce
		body.ball_hit()

func reset_position() -> void:
	global_position = initial_position
	var random_direction = get_random_direction()
	move_dir = Vector2(random_direction, 0)
	is_moving = false
	
func get_random_direction() -> int:
	var x_initial_directions = [1, -1]
	return x_initial_directions.pick_random()

func set_direction(player: String) -> void:
	match player:
		"1":
			move_dir = Vector2(-1, 0)
		"2":
			move_dir = Vector2(1, 0)
		_:
			var random_direction = get_random_direction()
			move_dir = Vector2(random_direction, 0)

func serve_ball() -> void:
	speed = initial_speed
	is_moving = true
