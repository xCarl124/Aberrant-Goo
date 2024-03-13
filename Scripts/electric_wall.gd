class_name ElectricWall
extends Area2D

@onready var electric_line = $ElectricLine
var _line_points: PackedVector2Array


func _ready():
	for i in 21:
		_line_points.append(Vector2(10 * i, 0))
	electric_line.points = _line_points


func _process(delta):
	for i in electric_line.get_point_count() - 2:
		electric_line.set_point_position(i + 1, _line_points[i + 1] + Vector2(0, randf_range(-7, 7)))


func _on_body_entered(body):
	if body is Human or body is GooBall:
		body.destroy()
