extends Area2D

const SPEED = 2
var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += direction * (SPEED + delta)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# TODO: Change to use a score system
	get_tree().change_scene_to_file("res://scenes/scenary.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		direction = direction * -1
