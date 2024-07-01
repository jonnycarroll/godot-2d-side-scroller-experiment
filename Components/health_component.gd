extends Node
class_name HealthComponent

@export var max_health : float = 10.0

signal damaged(node : HealthComponent, attack : Attack)

var health : float

func _ready():
	health = max_health

func damage(attack : Attack):
	health = max(health - attack.attack_damage, 0)
	SignalBus.health_changed.emit(get_parent(), -1 * attack.attack_damage)
	damaged.emit(self, attack)
