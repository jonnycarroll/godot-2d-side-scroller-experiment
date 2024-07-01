extends CharacterState
class_name HideState

@export var hitbox_component : HitboxComponent
@export var hide_time : float = 0.8

signal hiding(protected : bool)

var timer : SceneTreeTimer

func enter():
	playback.travel("hide")
	hitbox_component.vulnerable = false

func exit():
	hitbox_component.vulnerable = true

func _on_hitbox_component_body_entered(body):
	if body is Player:
		if timer:
			timer.timeout.disconnect(_on_timer_timeout)
		transitioned.emit(self, "hide", true)

func _on_hitbox_component_body_exited(body):
	if body is Player:
		timer = get_tree().create_timer(hide_time)
		timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	playback.travel("unhide")

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "unhide":
		transitioned.emit(self, "walk")
