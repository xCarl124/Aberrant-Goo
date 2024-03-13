class_name GooBall
extends RigidBody2D

var _prev_vel_sign: int = 0
@export var impulse_force: int = 400

@onready var aim_line: Line2D = $"Aim Line"
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var ball_sprite = $"Ball Sprite"
@onready var face = $Face
@onready var audio_player = $"Audio Player"


func _process(_delta):
	var angle: float = 0
	if abs(linear_velocity) > Vector2(0.2, 0.2):
		angle = linear_velocity.angle()
		face.get_child(0).flip_v = sign(linear_velocity.x) < 0
		_prev_vel_sign = sign(linear_velocity.x)
	else:
		if _prev_vel_sign < 0:
			angle = deg_to_rad(180)
	
	face.rotation = angle

func trow_ball(dir: Vector2, distance: float):
	if linear_velocity.distance_to(Vector2.ZERO) <= 0.01:
		check_in_creature()
		# Shoot the ball
		call_deferred("apply_central_impulse", dir * clampf(distance / 150.0, 0, 1) * impulse_force)
		update_aim()


func update_aim(dir: Vector2 = Vector2.ZERO, distance: float = 0):
	if linear_velocity.distance_to(Vector2.ZERO) <= 0.01:
		var end_point: Vector2 = dir * clampf(distance, 0, 150)
		aim_line.set_point_position(1, end_point)


func _on_body_entered(body):
	if body is Human:
		body.aberrate()
		get_parent().call_deferred("remove_child", self)
		body.call_deferred("add_child", self)
		control_creature()
	else:
		audio_player.play()


func control_creature():
	hitbox.set_deferred("disabled", true)
	set_deferred("freeze", true)
	ball_sprite.visible = false
	position = Vector2.ZERO
	linear_velocity = Vector2.ZERO


func check_in_creature():
	var parent = get_parent()
	var root = get_tree().root.get_child(0)
	if parent != root:
		# Set root as parent
		parent.remove_child(self)
		root.add_child(self)
		# Activate ball again
		position = parent.position
		hitbox.set_deferred("disabled", false)
		set_deferred("freeze", false)
		ball_sprite.visible = true
		# Destroy creature
		InputManager.instance().remove_creature()
		parent.destroy()


func destroy():
	DeathParticles.instance().emit_particles(position)
	InputManager.instance().is_alive = false
	queue_free()
