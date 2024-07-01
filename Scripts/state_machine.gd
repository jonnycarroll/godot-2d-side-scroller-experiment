extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
			initialize_state(child)
		else:
			push_warning("Child " + child.name + " is not a State for " + self.name)
	
	if initial_state:
		if !states.has(initial_state.name.to_lower()):
			push_error("State Machine " + self.name + " failed to set Initial State with name " + initial_state.name)
			return
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func initialize_state(state : State):
	pass

func on_child_transition(state : State, new_state_name : String, allow_interruption : bool = false):
	if state != current_state && !allow_interruption:
		return
		
	var new_state : State = states.get(new_state_name.to_lower())
	if !new_state:
		push_error("State Machine " + self.name + " could not find New State with name " + new_state_name)
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
