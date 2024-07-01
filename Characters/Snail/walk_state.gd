extends CharacterState
class_name WalkState

@export var default_movement_direction : Vector2 = Vector2.LEFT

var direction : Vector2

func enter():
	playback.travel("walk")
	if !direction:
		direction = default_movement_direction
	character.velocity.x = direction.x * character.movement_speed
