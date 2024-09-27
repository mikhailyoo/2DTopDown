extends CharacterBody2D

var max_speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = movement_vector()
	var direction = movement.normalized()
	velocity = max_speed * direction
	move_and_slide()
#

func movement_vector():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x,movement_y)
