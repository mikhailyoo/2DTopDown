extends Node

@onready var gold_text: Label = %GoldText

var save_path = "user://game.save"

var gold: int

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}


func _ready() -> void:
	load_file()
	update_gold()
	

func save_file():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(save_data)
	
	
func load_file():
	if not FileAccess.file_exists(save_path):
		return
	var file = FileAccess.open(save_path, FileAccess.READ)
	save_data = file.get_var()
	
	
func add_meta_upgrade(upgrade: MetaUpgrade):
	if not save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}
		
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	

func get_upgrade_quantity(upgrade_id: String):
	if save_data["meta_upgrades"].has(upgrade_id):
		return save_data["meta_upgrades"][upgrade_id]["quantity"]
	return 0
	
	
func update_gold():
	gold = save_data["meta_upgrade_currency"]
	gold_text.text = str(gold)
	save_file()
	
