extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var invulnerable_time : float = 0.2
@export var sparks_particle : GPUParticles2D

signal vulnerability_changed(vulnerable : bool)

var vulnerable : bool = true:
	set(value):
		vulnerable = value
		vulnerability_changed.emit(vulnerable)

func _ready():
	$Timer.wait_time = invulnerable_time

func damage(attack : Attack):
	if health_component && vulnerable:
		health_component.damage(attack)
		vulnerable = false
		$Timer.start()
	
	if !vulnerable && sparks_particle:
		sparks_particle.emitting = true

func _on_timer_timeout():
	vulnerable = true
