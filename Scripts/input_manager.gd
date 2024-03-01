class_name InputManager
extends Node2D

static var manager: InputManager

var _start_point: Vector2
var _is_clicking := false
var creature: Node2D
@export var ball: GooBall

func _ready():
	manager = self


static func instance():
	return manager


func _unhandled_input(_event):
	# Start tracking the mouse
	if Input.is_action_just_pressed("left_click"):
		_start_point = get_global_mouse_position()
		_is_clicking = true
	# Stop tracking the mouse and shoot goo ball
	if Input.is_action_just_released("left_click") and _is_clicking:
		_is_clicking = false
		var current_point: Vector2 = get_global_mouse_position()
		var dir = (_start_point - current_point).normalized()
		var distance = _start_point.distance_to(current_point)
		ball.trow_ball(dir, distance)
	# Stop tracking the mouse and cancel shoot
	if Input.is_action_just_pressed("right_click"):
		_is_clicking = false
		ball.update_aim()


func _process(_delta):
	# Click holding
	if _is_clicking:
		var current_point: Vector2 = get_global_mouse_position()
		var dir = (_start_point - current_point).normalized()
		var distance = _start_point.distance_to(current_point)
		ball.update_aim(dir, distance)
	
	if creature:
		# Creature inputs
		var dir = Input.get_axis("left_dir", "right_dir")
		creature.set_direction(dir)


func set_creature(c):
	print_debug("creature set: " + c.name)
	creature = c
	#creature.add_child(ball)
	#ball.position = Vector2.ZERO
