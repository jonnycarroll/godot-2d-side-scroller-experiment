extends CharacterState
class_name AirState

@export var double_jump_velocity : float = -100.0
@export var double_jump_animation : String = "double_jump"

var has_double_jumped : bool = false

func physics_update(_delta):
	if (character.is_on_floor()):
		transitioned.emit(self, "landing")

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()

func exit():
	has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true
