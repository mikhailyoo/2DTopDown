extends CanvasLayer
class_name EndScreen

@onready var name_label = %NameLabel


func _ready():
	get_tree().paused = true
	

func change_to_victory():
	name_label.text = "Victory"


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/level/level.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
