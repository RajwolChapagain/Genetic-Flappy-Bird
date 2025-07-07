extends Area2D

@export var move_speed = 20
var moving: bool = false
var activated: bool = false:
	get:
		return activated
	set(value):
		activated = value
		
signal agent_crossed

func _physics_process(delta: float) -> void:
	if not moving:
		return
		
	position.x -= move_speed * delta

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group('agent'):
		if body.alive:
			activated = true
			agent_crossed.emit()
