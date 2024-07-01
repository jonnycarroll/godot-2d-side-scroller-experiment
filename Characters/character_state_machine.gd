extends StateMachine
class_name CharacterStateMachine

@export var animation_tree : AnimationTree

func initialize_state(state : State):
	state.character = get_parent()
	state.playback = animation_tree["parameters/playback"]

func check_if_can_move():
	return current_state.can_move

func _input(event : InputEvent):
	current_state.state_input(event)
