extends Area2D


@export var damage: int = 5
@export var speed: float = 200

var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += speed * direction * delta


func enemy_damage():
	return damage


func _on_body_entered(body: Node2D) -> void:
	queue_free()
