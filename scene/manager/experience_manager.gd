extends Node
class_name ExperienceManager

signal level_up (current_level)
signal experience_update (current_experience:float, target_experience:float)

var current_experience = 0
var target_experience = 1
var target_after_lvlup = 5
var current_level = 1


func _ready():
	Global.experience_bottle_collected.connect(on_experience_bottle_collected)
	

func on_experience_bottle_collected (experience):
	current_experience = min(current_experience + experience, target_experience)
	experience_update.emit(current_experience, target_experience)
	
	if current_experience == target_experience:
		current_level += 1
		current_experience = 0
		target_experience += target_after_lvlup
		experience_update.emit(current_experience, target_experience)
		level_up.emit(current_level)
