class_name DoorButton
extends Area2D

@export var door_hitbox: CollisionShape2D
@export var door_sprite: Sprite2D

func _on_body_entered(body):
	if body is Human:
		$Interaction_sprite.visible = true
		body.set_door_button(self)


func _on_body_exited(body):
	if body is Human:
		$Interaction_sprite.visible = false
		body.set_door_button(null)


func open_door():
	door_sprite.visible = false
	door_hitbox.set_deferred("disabled", true)
