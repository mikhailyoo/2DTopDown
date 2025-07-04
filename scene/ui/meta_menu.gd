extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

@onready var grid_container: GridContainer = %GridContainer

var meta_upgrade_card_scene = preload("res://scene/ui/meta_upgrade_card.tscn")

func _ready() -> void:
	for upgrade in upgrades:
		var meta_upgrade_card_instance = meta_upgrade_card_scene.instantiate()
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/main_menu.tscn")
