extends Node

@onready var timer = $Timer

@export var arena_time_manager: ArenaTimeManager
@export var mushroom_scene: PackedScene

var base_spawn_time
var min_spawn_time = 0.2
var difficulty_multiplier = 0.01

func _ready():
	base_spawn_time = timer.wait_time
	arena_time_manager.difficulty_increased.connect(on_difficulty_increased)

func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance = randi_range(380, 500)
	var spawn_pos = player.global_position + (random_direction * random_distance)
	
	
	var enemy = mushroom_scene.instantiate() as Node2D
	var back_layer = get_tree().get_first_node_in_group("back_layer")
	back_layer.add_child(enemy)
	
	enemy.global_position = spawn_pos
	
	
func on_difficulty_increased(difficulty_level:int):
	var new_spawn_time = max(min_spawn_time, (base_spawn_time - (difficulty_level * difficulty_multiplier)))
	timer.wait_time = new_spawn_time
	print(timer.wait_time)
