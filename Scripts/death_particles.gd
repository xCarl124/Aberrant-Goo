class_name DeathParticles
extends GPUParticles2D

static var particles: DeathParticles
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	particles = self


static func instance():
	return particles


func emit_particles(pos: Vector2):
	position = pos
	emitting = true
	audio_player.play()
