extends Area2D

onready var _animator: AnimationPlayer = get_node("AnimationPlayer")


# warning-ignore:unused_argument
func _on_body_entered(body: Node) -> void:
	_animator.play("fade_out")


# warning-ignore:unused_argument
func _on_body_exited(body: Node) -> void:
	_animator.play("fade_in")
