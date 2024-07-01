extends CharacterBody2D
class_name Player

enum PLAYER_FACING {LEFT, RIGHT}

@export var movement_speed : float = 200.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $PlayerStateMachine

signal facing_direction_changed(facing_direction : Vector2)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var current_facing_direction : int = PLAYER_FACING.RIGHT

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		
	update_animation_parameters()
	update_facing_direction()
	
	move_and_slide()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	var new_facing_direction : int
	if direction.x > 0:
		new_facing_direction = PLAYER_FACING.RIGHT
	elif direction.x < 0:
		new_facing_direction = PLAYER_FACING.LEFT
	else:
		return
	
	if new_facing_direction != current_facing_direction:
		if new_facing_direction == PLAYER_FACING.RIGHT:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		facing_direction_changed.emit(new_facing_direction)
		current_facing_direction = new_facing_direction

func _on_hitbox_component_vulnerability_changed(vulnerable):
	if !vulnerable:
		$Sprite2D/ShaderAnimationPlayer.play("damaged")
	else:
		$Sprite2D/ShaderAnimationPlayer.stop()

func set_shader_parameter(param : String, value: float):
	$Sprite2D.material.set_shader_parameter(param, value)
