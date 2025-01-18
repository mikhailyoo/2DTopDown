class_name EnemyPool

var mobs: Array[Dictionary] = []
var weight_sum = 0


func add_mob(mob, weight: int):
	mobs.append({"mob": mob, "weight": weight})
	weight_sum += weight
	

func pick_mob():
	var random_weight = randi_range(1, weight_sum)
	for mob in mobs:
		random_weight -= mob["weight"]
		if random_weight <= 0:
			return mob["mob"]
