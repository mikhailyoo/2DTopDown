extends CanvasLayer

var options_menue_scene = preload("res://scene/ui/options_menu.tscn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/level/level.tscn")


func _on_options_button_pressed() -> void:
	var options_instance = options_menue_scene.instantiate()
	add_child(options_instance)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	

func _on_upgrades_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/meta_menu.tscn")
