class_name DoorButton
extends Area2D

var _not_opened := true

@export var door_hitbox: CollisionShape2D
@export var door_sprite: Sprite2D
@export var animator: AnimationPlayer
@onready var interaction_sprite = $Interaction_sprite

func _on_body_entered(body):
	if _not_opened and body is Human:
		interaction_sprite.visible = true
		body.set_door_button(self)


func _on_body_exited(body):
	if _not_opened and body is Human:
		interaction_sprite.visible = false
		body.set_door_button(null)


func open_door():
	if _not_opened:
		interaction_sprite.visible = false
		animator.play("close_door")
