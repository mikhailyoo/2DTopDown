extends PanelContainer
class_name AbilityUpgradeCard

signal card_selected


@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var animation_player = $AnimationPlayer

var disabled = false


func set_ability_upgrade (upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func play_in(delay):
	modulate.a = 0
	await get_tree().create_timer(delay).timeout
	animation_player.play("in")

func _on_gui_input(event):
	if disabled:
		return
		
	if event.is_action_pressed("left_click"):
		disabled = true
		for card in get_tree().get_nodes_in_group("upgrade_card"):
			if card == self:
				animation_player.play("selected")
			else:
				card.animation_player.play("discard")
		await animation_player.animation_finished
		card_selected.emit()


func _on_mouse_entered():
	if disabled:
		return
	scale = Vector2 (1.05, 1.05)


func _on_mouse_exited():
	if disabled:
		return
	scale = Vector2 (1, 1)
