class_name AIBehaviorManager
extends Node2D

var is_cpu = true
var reaction_time = 0.2
var hit_with: HitWith
var ball: Ball
var oponent: Player

enum HitWith {
	TOP = 1,
	CENTER,
	BOTTOM
}

func _physics_process(delta: float) -> void:
	if is_cpu:
		await get_tree().create_timer(reaction_time).timeout
		_execute_action()

func _execute_action() -> void:
	if ball:
		var parent = get_parent() as Player
		## Set direction
		var paddle_height = parent.get_node("CollisionShape2D").shape.get_rect().size.y
		var third_height = paddle_height / 3
		var hit_point = paddle_height/2
		var direction = Vector2.ZERO
		hit_with = HitWith.CENTER
		
		match hit_with:
			HitWith.TOP:
				hit_point = parent.global_position.y - third_height
			HitWith.CENTER:
				hit_point = parent.global_position.y
			HitWith.BOTTOM:
				hit_point = parent.global_position.y + third_height
				
		
		if hit_point > ball.global_position.y:
			direction.y -= 1
		elif hit_point < ball.global_position.y:
			direction.y += 1
		else:
			direction.y = 0
			
		parent.cpu_direction = direction
		print(parent.cpu_direction)


#func _physics_process(delta: float) -> void:
	#if playing && is_player:
		#var direction = Vector2.ZERO
		#if Input.is_action_pressed(up_input):
			#direction.y -= 1
		#if Input.is_action_pressed(down_input):
			#direction.y += 1
		#
		#velocity += direction * SPEED * delta
		#if direction.y == 0.0:
			#velocity.y = move_toward(velocity.y, 0.0, SLOW_DOWN_DELTA)
			#
		#velocity.y = clampf(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)
		#
		#global_position.y += velocity.y
		#global_position.y = clampf(global_position.y, top, down)
