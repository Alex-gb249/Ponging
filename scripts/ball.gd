extends Area2D

const BASE_SPEED = 150
const SPEED_INCREASE = 15
const MAX_SPEED = 350

var velocity = Vector2.ZERO
var current_speed: float = BASE_SPEED
var last_paddle_hit: Node2D = null

func _ready() -> void:
	randomize()
	_start_ball()

func _start_ball() -> void:
	current_speed = BASE_SPEED
	last_paddle_hit = null
	var angle = randf_range(-PI / 4, PI / 4)
	var direction = -1 if randf() < 0.5 else 1
	velocity = _make_velocity(angle, direction)

func _make_velocity(angle: float, direction: int) -> Vector2:
	var new_velocity = Vector2(cos(angle) * direction, sin(angle)).normalized() * current_speed
	if abs(new_velocity.y) < 0.2:
		new_velocity.y = 0.2 * sign(new_velocity.y) if new_velocity.y != 0 else 0.2
		new_velocity = new_velocity.normalized() * current_speed
	return new_velocity

func _increase_speed() -> void:
	current_speed = min(current_speed + SPEED_INCREASE, MAX_SPEED)

func _get_paddle_hit_offset(body: Node2D) -> float:
	if body.has_node("Size"):
		var shape = body.get_node("Size").shape
		if shape is RectangleShape2D:
			return clamp((global_position.y - body.global_position.y) / (shape.size.y * 0.5), -1.0, 1.0)
	return 0.0

func _process(delta: float) -> void:
	global_position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# TODO: Change to use a score system
	get_tree().change_scene_to_file("res://scenes/scenary.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		if last_paddle_hit != null and last_paddle_hit != body:
			_increase_speed()
		last_paddle_hit = body

		var hit_offset = _get_paddle_hit_offset(body)
		var max_angle = PI / 3
		var angle = hit_offset * max_angle
		var x_dir = -sign(velocity.x)
		velocity = _make_velocity(angle, x_dir)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Walls"):
		velocity.y = -velocity.y
