extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10
@export var damage_text_scene: PackedScene
var current_health: float


func _ready():
	current_health = max_health
	
	
func take_damage (damage):
	var front_layer = get_tree().get_first_node_in_group("front_layer") as Node2D
	var damage_text_instance = damage_text_scene.instantiate() as Node2D
	front_layer.add_child(damage_text_instance)
	damage_text_instance.global_position = owner.global_position
	damage_text_instance.damage_text(damage)
	current_health = max(current_health - damage, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()
	

func get_health_value():
	return current_health / max_health
	
	
func check_death ():
	if current_health == 0:
		died.emit()
	
