extends Node2D


var bottle_experience = 1


func _on_area_2d_area_entered(area):
	Global.experience_bottle_collected.emit(bottle_experience)
	queue_free()
