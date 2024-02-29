class_name GooBall
extends RigidBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 400.0

@export var aim_line: Line2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#func _physics_process(delta):

func trow_ball(dir: Vector2, distance: float):
	apply_central_impulse(dir * (distance / 150.0) * JUMP_VELOCITY)

func update_aim(dir: Vector2, distance: float):
	var end_point: Vector2 = dir * clampf(distance, 0, 150)
	aim_line.set_point_position(1, end_point)
