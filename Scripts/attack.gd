class_name Attack

var attack_damage : float = 0.0
var knockback_force : float = 1.0
var attacker_position : Vector2
var enemy_position : Vector2
var stun_time : float = 0.8

func knockback_direction_x() -> Vector2:
	var direction_to_damageable = enemy_position - attacker_position
	var direction_sign = sign(direction_to_damageable.x)
			
	if direction_sign > 0:
		return Vector2.RIGHT
	elif direction_sign < 0:
		return Vector2.LEFT
	else:
		return Vector2.ZERO
