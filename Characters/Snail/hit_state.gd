extends CharacterState
class_name HitState

var timer : SceneTreeTimer

func enter():
	playback.travel("stun")

func _on_health_component_damaged(health_component : HealthComponent, attack : Attack):
	if health_component.health > 0:
		character.velocity = attack.knockback_force * attack.knockback_direction_x()
		timer = get_tree().create_timer(attack.stun_time)
		timer.timeout.connect(_on_timer_timeout)
		transitioned.emit(self, "hit", true)
	else:
		transitioned.emit(self, "dead", true)

func _on_timer_timeout():
	transitioned.emit(self, "walk")
