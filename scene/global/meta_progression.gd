extends Node

var save_path = "user://game.save"

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}


func _ready() -> void:
	Global.experience_bottle_collected.connect(on_experience_collected)
	load_file()
	

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
	

func on_experience_collected(number: float):
	save_data["meta_upgrade_currency"] += number
	save_file()
	print(save_data)
