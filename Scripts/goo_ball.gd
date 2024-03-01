class_name GooBall
extends RigidBody2D

@export var impulse_force: int = 400
@export var aim_line: Line2D

func trow_ball(dir: Vector2, distance: float):
	if linear_velocity.distance_to(Vector2.ZERO) <= 0.01:
		apply_central_impulse(dir * clampf(distance / 150.0, 0, 1) * impulse_force)
		update_aim()


func update_aim(dir: Vector2 = Vector2.ZERO, distance: float = 0):
	if linear_velocity.distance_to(Vector2.ZERO) <= 0.01:
		var end_point: Vector2 = dir * clampf(distance, 0, 150)
		aim_line.set_point_position(1, end_point)


func _on_body_entered(body):
	if body is CharacterBody2D:
		body.aberrate()
		get_parent().remove_child(self)
		body.add_child(self)
		control_creature()


func control_creature():
	$Hitbox.set_deferred("disabled", true)
	set_deferred("freeze", true)
	position = Vector2.ZERO
	linear_velocity = Vector2.ZERO
