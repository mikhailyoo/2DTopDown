extends Node2D

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func damage_text(damage):
	var format_text = "%0.1f"
	if damage == round(damage):
		format_text = "%0.0f"
	label.text = (format_text % damage)
	animation_player.play("damage_text")
