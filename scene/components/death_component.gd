extends Node2D
class_name DeathComp

@onready var gpu_particles_2d = %GPUParticles2D
@onready var sprite_offset = $SpriteOffset

func _ready() -> void:
	$HitSoundComponent.play()
	$AudioStreamPlayer2D.play()
