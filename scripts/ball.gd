extends Area2D

const SPEED = 1.5
var directionX = 1
var directionY = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += directionX * (SPEED + delta)
	global_position.y += directionY * (SPEED + delta)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# TODO: Change to use a score system
	get_tree().change_scene_to_file("res://scenes/scenary.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		directionX = directionX * -1


func _on_area_entered(area: Area2D) -> void:
	print("Area entered:", area.name, area.get_groups())
	if area.is_in_group("Walls"):
		directionY = directionY * -1
