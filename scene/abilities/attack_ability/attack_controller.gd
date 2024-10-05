extends Node

@export var attack_ability: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var attack_instance = attack_ability.instantiate() as Node2D
	player.get_parent().add_child(attack_instance)
	attack_instance.global_position = player.global_position
