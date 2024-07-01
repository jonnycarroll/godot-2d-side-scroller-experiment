extends Area2D

@export var damage : int = 10
@export var knockback_force : float = 250.0

@onready var attack_box : CollisionShape2D = $AttackBox

func _ready():
	monitoring = false

func _on_hitbox_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.knockback_force = knockback_force
		attack.attacker_position = get_parent().global_position
		attack.enemy_position = area.global_position
		
		hitbox.damage(attack)

func _on_player_facing_direction_changed(facing_direction : int):
	match facing_direction:
		Player.PLAYER_FACING.RIGHT:
			attack_box.position.x = abs(attack_box.position.x)
		Player.PLAYER_FACING.LEFT:
			attack_box.position.x = abs(attack_box.position.x) * -1
		_:
			push_error("Unknown Player facing direction of " + str(facing_direction))
