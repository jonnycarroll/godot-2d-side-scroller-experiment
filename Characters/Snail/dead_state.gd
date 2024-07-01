extends CharacterState
class_name DeadState

func enter():
	playback.travel("dead")

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "dead":
		character.queue_free()
