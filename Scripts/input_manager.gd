class_name InputManager
extends Node2D

static var manager: InputManager

var _start_point: Vector2
var _is_clicking := false
@export var ball: GooBall

func _ready():
	manager = self


static func instance():
	return manager


func _unhandled_input(_event):
	if Input.is_action_just_pressed("left_click"):
		_start_point = get_global_mouse_position()
		_is_clicking = true
	if Input.is_action_just_released("left_click"):
		_is_clicking = false
		var current_point: Vector2 = get_global_mouse_position()
		var dir = (_start_point - current_point).normalized()
		var distance = _start_point.distance_to(current_point)
		ball.trow_ball(dir, distance)


func _process(_delta):
	if _is_clicking:
		var current_point: Vector2 = get_global_mouse_position()
		var dir = (_start_point - current_point).normalized()
		var distance = _start_point.distance_to(current_point)
		ball.update_aim(dir, distance)


func debug_test():
	print_debug("Momazos diego")
