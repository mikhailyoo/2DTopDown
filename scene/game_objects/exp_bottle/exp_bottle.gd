extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D

var bottle_experience = 1

func tween_exp_bottle(percent: float, start_position: Vector2):
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	global_position = start_position.lerp(player.global_position, percent)
	
	var direction = player.global_position - start_position
	var direction_degrees = rad_to_deg(direction.angle())
	
	rotation = lerp_angle(rotation, direction_degrees, 0.05)

func exp_collected():
	Global.experience_bottle_collected.emit(bottle_experience)
	queue_free()
	
func disable_collision():
	collision_shape_2d.disabled = true

func _on_area_2d_area_entered(area):
	Callable(disable_collision).call_deferred()
	var rng = randi_range(20, 40)
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var away_point = global_position + (global_position - player.global_position)\
	.normalized() * rng
	var tween_out = create_tween()
	tween_out.tween_property(self, "global_position", away_point, .4)\
	.set_ease(Tween.EASE_OUT)\
	.set_trans(Tween.TRANS_CUBIC)
	await tween_out.finished
	var tween = create_tween()
	tween.tween_method(tween_exp_bottle.bind(global_position), 0.0, 1.0, 0.3)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(exp_collected)
