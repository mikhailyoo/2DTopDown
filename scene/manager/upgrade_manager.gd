extends Node

@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

var upgrade_pool: UpgradePool = UpgradePool.new()

var upgrade_sword_rate = preload("res://resources/upgrades/sword_rate.tres")
var upgrade_throw_axe = preload("res://resources/upgrades/throw_axe.tres")
var upgrade_sword_damage = preload("res://resources/upgrades/sword_damage.tres")
var upgrade_axe_damage = preload("res://resources/upgrades/axe_damage.tres")
var upgrade_move_speed = preload("res://resources/upgrades/move_speed.tres")


var current_upgrades = {}


func _ready():
	upgrade_pool.add_upgrade(upgrade_sword_rate, 10)
	upgrade_pool.add_upgrade(upgrade_throw_axe, 10)
	upgrade_pool.add_upgrade(upgrade_sword_damage, 10)
	upgrade_pool.add_upgrade(upgrade_move_speed, 10)

	
	experience_manager.level_up.connect(on_level_up)
	
	
func apply_upgrade (upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"upgrade": upgrade,
			"quantity": 1
		}
		
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
		
	update_upgrade_pool(upgrade)
	
	Global.ability_upgrade_added.emit(upgrade, current_upgrades)
	
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_upgrade(upgrade)
	
	
func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	if chosen_upgrade.id == upgrade_throw_axe.id:
		upgrade_pool.add_upgrade(upgrade_axe_damage, 10)
	
	
func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade]
	for i in 3:
		if upgrade_pool.upgrades.size() == chosen_upgrades.size():
			break
		var chosen_upgrade = upgrade_pool.pick_upgrade(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)
	
	return chosen_upgrades
		
		
func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
	
	
func on_level_up (current_level):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
