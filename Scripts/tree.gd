extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var path: Curve2D = $Path.curve
@onready var tentacle: Line2D = $Tentacle
@onready var audio_player = $"Audio Player"
@onready var particles = $CPUParticles2D
var _normal := true

func _on_trigger_entered(body):
	if _normal and body.name == "Player":
		_normal = false
		audio_player.play()
		particles.emitting = true
		sprite.play("aberrate")
		await draw_tentacle()
		$Platform.process_mode = Node.PROCESS_MODE_INHERIT
		$Platform/Sprite2D.visible = true

func draw_tentacle():
	var last_point: int = path.point_count - 1
	for point in last_point:
		for i in 10:
			tentacle.add_point(path.sample(point, i * 0.1))
			tentacle.add_point(path.sample(point, i * 0.1 + 0.05))
			await get_tree().create_timer(0.05).timeout
	tentacle.add_point(path.get_point_position(last_point))
