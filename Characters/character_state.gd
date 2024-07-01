extends State
class_name CharacterState

@export var can_move : bool = true

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback

func state_input(_event : InputEvent):
	pass
