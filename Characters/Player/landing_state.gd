extends CharacterState
class_name LandingState

@export var landing_animation : String = "jump_end"

func enter():
	playback.travel(landing_animation)

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == landing_animation):
		transitioned.emit(self, "ground")
