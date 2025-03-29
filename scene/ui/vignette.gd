extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("RESET")
	Global.player_damaged.connect(on_damaged)
	
	
func on_damaged():
	animation_player.play("get_hit")
