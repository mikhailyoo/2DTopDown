extends CanvasLayer
class_name EndScreen

@onready var name_label = %NameLabel
@onready var panel_container: PanelContainer = $MarginContainer/PanelContainer
@onready var gold_text_label: Label = %GoldTextLabel


func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	get_tree().paused = true
	
	
func update_gold_to_add(gold_to_add):
	gold_text_label.text = "Gold + " + str(gold_to_add)
	MetaProgression.save_data["meta_upgrade_currency"] += gold_to_add
	MetaProgression.update_gold()


func change_to_victory():
	name_label.text = "Victory"
	

func play_jingle(victory: bool = false):
	if victory:
		$VictorySound.play()
	else:
		$DefeatSound.play()


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/level/level.tscn")


func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/ui/main_menu.tscn")
