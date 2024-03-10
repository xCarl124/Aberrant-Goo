class_name Human
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _direction: int = 0
var button: DoorButton
var on_animation := false

@onready var sprite = $Sprite
@onready var animator = $AnimationPlayer


func _physics_process(delta):
	# Gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if _direction:
		velocity.x = _direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func set_direction(dir: int):
	if !on_animation:
		_direction = dir
		if dir != 0:
			sprite.scale.x = dir * 2


func aberrate():
	InputManager.instance().set_creature(self)
	animator.play("aberrate")


func destroy():
	queue_free()


func set_door_button(b: DoorButton):
	button = b


func interact():
	if button:
		button.open_door()
		animator.play("button_press")


func set_on_animation(b: bool):
	on_animation = b
