class_name GooBall
extends RigidBody2D

@export var impulse_force: int = 400
@export var aim_line: Line2D

func trow_ball(dir: Vector2, distance: float):
	apply_central_impulse(dir * clampf(distance / 150.0, 0, 1) * impulse_force)


func update_aim(dir: Vector2, distance: float):
	var end_point: Vector2 = dir * clampf(distance, 0, 150)
	aim_line.set_point_position(1, end_point)


func _on_body_entered(body):
	var collision = get_colliding_bodies()
	if collision[0] is PhysicsBody2D:
		InputManager.instance().debug_test()
