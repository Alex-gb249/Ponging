extends Area2D

const SPEED = 1
var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += direction * (SPEED + delta)


func _on_area_entered(area: Area2D) -> void:
	print("Body entered: ", area.name)
	if area.is_in_group("Players"):
		direction = direction * -1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	direction = direction * -1
