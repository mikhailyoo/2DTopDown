extends CharacterBody2D

@onready var health_component = $HealthComponent
@onready var grace_period = $GracePeriod
@onready var progress_bar = $ProgressBar

var max_speed = 125
var acceleration = .15
var enemies_colliding = 0

func _ready():
	health_component.died.connect(on_died)
	health_component.health_changed.connect(on_health_changed)
	health_update()


func _process(delta):
	var direction = movement_vector().normalized()
	var target_velocity = max_speed * direction
	
	velocity = velocity.lerp(target_velocity, acceleration)
	move_and_slide()
	
func movement_vector():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x, movement_y)
	
	
func check_if_damaged():
	if enemies_colliding == 0 || !grace_period.is_stopped():
		return
	health_component.take_damage(1)
	grace_period.start()
	
	print(health_component.current_health)
	
	
func health_update():
	progress_bar.value = health_component.get_health_value()
	
func _on_player_hurt_box_area_entered(area):
	enemies_colliding += 1
	check_if_damaged()


func _on_player_hurt_box_area_exited(area):
	enemies_colliding -= 1


func on_died():
	queue_free()
	

func on_health_changed():
	health_update()


func _on_grace_period_timeout():
	check_if_damaged()
