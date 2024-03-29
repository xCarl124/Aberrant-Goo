class_name InputManager
extends Node2D

static var manager: InputManager

var _start_point: Vector2
var _is_clicking := false
var is_alive := true
var creature: Node2D
var ball: GooBall
@onready var aim_centre = $Center

func _ready():
	manager = self
	ball = get_node("../Player")


static func instance():
	return manager


func _unhandled_input(_event):
	if is_alive:
		# Start tracking the mouse
		if Input.is_action_just_pressed("left_click"):
			_start_point = get_global_mouse_position()
			_is_clicking = true
			aim_centre.visible = true
			aim_centre.position = _start_point
		# Stop tracking the mouse and shoot goo ball
		if Input.is_action_just_released("left_click") and _is_clicking:
			_is_clicking = false
			var current_point: Vector2 = get_global_mouse_position()
			var dir = (_start_point - current_point).normalized()
			var distance = _start_point.distance_to(current_point)
			aim_centre.visible = false
			ball.trow_ball(dir, distance)
		# Stop tracking the mouse and cancel shoot
		if Input.is_action_just_pressed("right_click"):
			_is_clicking = false
			aim_centre.visible = false
			ball.update_aim()
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _process(_delta):
	# Click holding
	if _is_clicking and is_alive:
		var current_point: Vector2 = get_global_mouse_position()
		var dir = (_start_point - current_point).normalized()
		var distance = _start_point.distance_to(current_point)
		ball.update_aim(dir, distance)
	
	if creature:
		# Creature inputs
		var dir = Input.get_axis("left_dir", "right_dir")
		creature.set_direction(dir)
		if Input.is_action_just_pressed("interact"):
			creature.interact()


func set_creature(c):
	creature = c


func remove_creature():
	creature = null
