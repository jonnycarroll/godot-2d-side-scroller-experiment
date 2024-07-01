extends CharacterState
class_name AttackState

@export var attack2_time_window : float = 0.3

@onready var timer : Timer = $Timer

func state_input(event : InputEvent):
	if event.is_action_pressed("attack"):
		timer.wait_time = attack2_time_window
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack1":
		if timer.is_stopped():
			transitioned.emit(self, "ground")
		else:
			playback.travel("attack2")
	
	if anim_name == "attack2":
		transitioned.emit(self, "ground")
