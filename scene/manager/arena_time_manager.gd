extends Node
class_name ArenaTimeManager

signal difficulty_increased(difficulty_level: int)

@export var end_screen_scene: PackedScene
@export var game_length: float = 600


@onready var timer = $Timer
@onready var difficulty_timer = $DifficultyTimer

var difficulty_level: int = 0


func _ready() -> void:
	timer.start(game_length)
	

func gold_to_add():
	return floor(get_time_elapsed() / 10)
	

func get_time_elapsed():
	return game_length - timer.time_left


func _on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	get_parent().add_child(end_screen_instance)
	end_screen_instance.change_to_victory()
	end_screen_instance.update_gold_to_add(gold_to_add())
	end_screen_instance.play_jingle(true)


func _on_difficulty_timer_timeout():
	difficulty_level += 1
	difficulty_increased.emit(difficulty_level)
