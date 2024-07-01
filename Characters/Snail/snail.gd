extends CharacterBody2D

@export var movement_speed : float = 30.0
@export var damage : float = 5.0
@export var knockback_force : float = 50.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $SnailStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var deal_damage : bool = false

func _ready():
	animation_tree.active = true

func _process(delta):
	for area in $HitboxComponent.get_overlapping_areas():
		if area is HitboxComponent:
			var hitbox : HitboxComponent = area
			
			var attack = Attack.new()
			attack.attack_damage = damage
			attack.knockback_force = knockback_force
			attack.attacker_position = get_parent().global_position
			attack.enemy_position = area.global_position
			
			hitbox.damage(attack)

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if !state_machine.check_if_can_move():
		velocity.x = move_toward(velocity.x, 0, movement_speed)
	
	move_and_slide()
