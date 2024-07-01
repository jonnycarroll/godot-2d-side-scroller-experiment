extends CharacterState
class_name GroundState

@export var jump_velocity : float = -150.0

func enter():
	playback.travel("move")

func physics_update(_delta):
	if (!character.is_on_floor()):
		transitioned.emit(self, "air")

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("attack")):
		attack()
		
func jump():
	character.velocity.y = jump_velocity
	transitioned.emit(self, "air")
	playback.travel("jump_start")

func attack():
	transitioned.emit(self, "attack")
	playback.travel("attack1")
