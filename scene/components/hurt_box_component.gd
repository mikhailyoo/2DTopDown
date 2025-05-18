extends Area2D
class_name HurtBoxComponent


@export var health_component: HealthComponent
@export var hit_sound_component: AudioStreamPlayer2D


func _on_area_entered(area: Area2D):
	if not area is HitBoxComponent:
		return
		
	if health_component == null:
		return
		
	var hit_box_component = area as HitBoxComponent
	health_component.take_damage(hit_box_component.damage)
	hit_sound_component.play()
