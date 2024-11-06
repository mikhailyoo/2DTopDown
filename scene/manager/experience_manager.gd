extends Node


var current_experience = 0


func _ready():
	Global.experience_bottle_collected.connect(on_experience_bottle_collected)
	

func on_experience_bottle_collected (experience):
	current_experience += experience
	print(current_experience)
