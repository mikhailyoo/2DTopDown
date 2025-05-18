extends CanvasLayer

@export var experience_manager: ExperienceManager
@onready var progress_bar = $MarginContainer/ProgressBar

func _ready():
	progress_bar.value = 0
	experience_manager.experience_update.connect(on_experience_updated)
	

func on_experience_updated(current_experience: float, target_ecperience: float):
	var current_value = current_experience / target_ecperience
	progress_bar.value = current_value
