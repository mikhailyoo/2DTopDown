extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = $MarginContainer/PanelContainer

var options_menu_scene = preload("res://scene/ui/options_menu.tscn")

var is_closing = false

func _ready() -> void:
	panel_container.pivot_offset = panel_container.size / 2
	get_tree().paused = true
	animation_player.play("in")
	
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	
func close():
	if is_closing:
		return
		
	is_closing = true
	
	animation_player.play_backwards("in")
	
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, .3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	
	await  tween.finished
	
	get_tree().paused = false
	
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		close()


func _on_resume_button_pressed() -> void:
	close()


func _on_options_button_pressed() -> void:
	add_child(options_menu_scene.instantiate())


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	MusicPlayer.stop()
	get_tree().change_scene_to_file("res://scene/ui/main_menu.tscn")
