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

func _ready() -> void:
	var parent = get_parent() as Player
	parent.hit.connect(select_hit)
	hit_with = HitWith.CENTER

func _physics_process(delta: float) -> void:
	if is_cpu && get_parent().playing:
		await get_tree().create_timer(reaction_time).timeout
		_execute_action()
		

func select_hit() -> void:
		hit_with = [HitWith.CENTER, HitWith.TOP, HitWith.BOTTOM].pick_random()

func _execute_action() -> void:
	if ball:
		var parent = get_parent() as Player
		## Set direction
		var paddle_height = parent.get_node("CollisionShape2D").shape.get_rect().size.y
		var third_height = paddle_height / 3
		var hit_point = paddle_height/2
		var direction = Vector2.ZERO
		var upper_third = 0
		var lower_third = 0
		
		
		match hit_with:
			HitWith.TOP:
				hit_point = parent.global_position.y - third_height
				upper_third = hit_point - (third_height/2)
				lower_third = parent.global_position.y
				print("Hit Top")
			HitWith.CENTER:
				hit_point = parent.global_position.y
				upper_third = hit_point - third_height
				lower_third = hit_point + third_height
				print("Hit Center")
			HitWith.BOTTOM:
				hit_point = parent.global_position.y + third_height
				upper_third = parent.global_position.y
				lower_third = hit_point + (third_height/2)
				print("Hit Bottom")
						
		var ball_position = ball.global_position.y
		
		
		if upper_third < ball_position && lower_third > ball_position:
			direction.y = 0
			print("Staying")
		elif ball_position > upper_third:
			direction.y = 1
			print("Going Down")
		elif ball_position < lower_third:
			direction.y = -1
			print("Going Up")
			
		parent.cpu_direction = direction
