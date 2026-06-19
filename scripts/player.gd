extends CharacterBody2D
class_name Player

const SPEED = 80

#@onready var screensize = get_viewport_rect().size
var limitTop
var limitBottom

func _ready() -> void:
	var screenHeight = get_viewport_rect().size.y
	var half_bar_height = $Size.shape.size.y / 2
	limitTop = half_bar_height
	limitBottom = screenHeight - half_bar_height

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("ui_w_letter", "ui_s_letter")
	velocity.y = direction * SPEED

	move_and_slide()
	
	position.y = clamp(position.y, limitTop, limitBottom)
