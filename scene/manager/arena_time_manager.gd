extends Node

@export var end_screen_scene: PackedScene

@onready var timer = $Timer


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func _on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	get_parent().add_child(end_screen_instance)
	end_screen_instance.change_to_victory()
