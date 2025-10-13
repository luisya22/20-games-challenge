class_name Player
extends CharacterBody2D

const SPEED = 50
var acceleration = 50.0
const MAX_VELOCITY = 10.0
const SLOW_DOWN_DELTA = 2.0
@export var top = 47
@export var down = 303
@export var player = "1"
var up_input = "paddle_up"
var down_input = "paddle_down"

func _ready() -> void:
	if player == "2":
		up_input += "_two"
		down_input += "_two"

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed(up_input):
		direction.y -= 1
	if Input.is_action_pressed(down_input):
		direction.y += 1
		
	velocity += direction * SPEED * delta
	if direction.y == 0.0:
		velocity.y = move_toward(velocity.y, 0.0, SLOW_DOWN_DELTA)
		
	velocity.y = clampf(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)
	
	global_position.y += velocity.y
	global_position.y = clampf(global_position.y, top, down)
	
	#for i in range(get_slide_collision_count()):
		#var collision = get_slide_collision(i)
		#print("Hit normal:", collision.get_normal(), " at ", collision.get_position())
		#
		#if collision.get_normal().y < 0:
			#print("Hit the ground (from above)")
		#elif collision.get_normal().y > 0:
			#print("Hit ceiling (from below)")
		#elif collision.get_normal().x != 0:
			#print("Hit wall")
