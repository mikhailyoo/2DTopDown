extends CanvasLayer
class_name UpgradeScreen

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container = $MarginContainer/CardContainer
@onready var animation_player = $AnimationPlayer


func _ready():
	get_tree().paused = true


func set_ability_upgrades (upgrades: Array[AbilityUpgrade]):
	var delay = 0
	for upgrade in upgrades:
		var upgrade_card_instance = upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(upgrade_card_instance)
		upgrade_card_instance.set_ability_upgrade(upgrade)
		upgrade_card_instance.play_in(delay)
		upgrade_card_instance.card_selected.connect(on_upgrade_selected.bind(upgrade))
		delay += 0.1
		
		
func on_upgrade_selected(upgrade:AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	animation_player.play("out")
	await animation_player.animation_finished
	get_tree().paused = false
	queue_free()
