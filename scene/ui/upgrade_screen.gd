extends CanvasLayer
class_name UpgradeScreen

@export var upgrade_card_scene: PackedScene

@onready var card_container = $MarginContainer/CardContainer


func _ready():
	get_tree().paused = true


func set_ability_upgrades (upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var upgrade_card_instance = upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(upgrade_card_instance)
		upgrade_card_instance.set_ability_upgrade(upgrade)
