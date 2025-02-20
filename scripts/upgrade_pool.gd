class_name UpgradePool

var upgrades: Array[Dictionary] = []
var weight_sum = 0


func add_upgrade(upgrade, weight: int):
	upgrades.append({"upgrade": upgrade, "weight": weight})
	weight_sum += weight
	

func remove_upgrade(applied_upgrade):
	upgrades = upgrades.filter(func(upgrade): return upgrade["upgrade"] != applied_upgrade)
	weight_sum = 0
	for upgrade in upgrades:
		weight_sum += upgrade["weight"]
	

func pick_upgrade(chosen_upgrades: Array):
	print(chosen_upgrades.size())
	var updated_upgrades: Array[Dictionary] = upgrades
	var updated_weight_sum = weight_sum
	
	if chosen_upgrades.size() > 0:
		updated_upgrades = []
		updated_weight_sum = 0
		for upgrade in upgrades:
			if upgrade["upgrade"] in chosen_upgrades:
				continue
			updated_upgrades.append(upgrade)
			updated_weight_sum += upgrade["weight"]
	
	var random_weight = randi_range(1, updated_weight_sum)
	for upgrade in updated_upgrades:
		random_weight -= upgrade["weight"]
		if random_weight <= 0:
			return upgrade["upgrade"]
