extends Node

@export var health_component: HealthComponent
@export var sprite: AnimatedSprite2D
@export var flash_material: ShaderMaterial

var flash_tween: Tween

func _ready():
	health_component.health_changed.connect(on_health_changed)
	sprite.material = flash_material
	
func on_health_changed():
	if flash_tween != null && flash_tween.is_valid():
		flash_tween.kill()
	(sprite.material as ShaderMaterial).set_shader_parameter("percent", 1.0)
	flash_tween = create_tween()
	flash_tween.tween_property\
	(sprite.material, "shader_parameter/percent", 0.0, .3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
