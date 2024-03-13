class_name DeathParticles
extends GPUParticles2D

static var particles: DeathParticles

func _ready():
	particles = self


static func instance():
	return particles


func emit_particles(pos: Vector2):
	position = pos
	emitting = true
