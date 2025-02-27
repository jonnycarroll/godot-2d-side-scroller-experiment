extends Control

@export var health_changed_label : PackedScene
@export var damage_color : Color = Color.DARK_RED
@export var heal_color : Color = Color.DARK_GREEN

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.health_changed.connect(_on_health_changed)

func _on_health_changed(node : Node, amount_changed : int):
	var label_instance : Label = health_changed_label.instantiate()
	label_instance.text = str(amount_changed)
	label_instance.position.y = -30.0
	
	if amount_changed >= 0:
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
		
	(func():
		node.add_child(label_instance)
	).call_deferred()
	
	var player_health_component : HealthComponent = $"../Player/HealthComponent" as HealthComponent
	$"../UI/MarginContainer/ProgressBar".value = player_health_component.health
