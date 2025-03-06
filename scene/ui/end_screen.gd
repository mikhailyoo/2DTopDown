extends CanvasLayer
class_name EndScreen

@onready var name_label = %NameLabel
@onready var panel_container: PanelContainer = $MarginContainer/PanelContainer


func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	get_tree().paused = true
	

func change_to_victory():
	name_label.text = "Victory"


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/level/level.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
