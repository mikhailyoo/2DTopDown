extends Node2D
class_name AxeAbility

@onready var hit_box_component = $HitBoxComponent

var axe_max_radius = 100
var base_direction = Vector2.RIGHT

func _ready():
	base_direction = base_direction.rotated(randf_range(0 , TAU))
	var tween = create_tween()
	tween.tween_method(rotation_animation, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)
	

func rotation_animation(rotations):
	var percent = rotations / 2
	var axe_current_radius = percent * axe_max_radius
	var axe_current_direction = base_direction.rotated(rotations * TAU)
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player== null:
		return
		
	global_position = player.global_position + (axe_current_direction * axe_current_radius)
