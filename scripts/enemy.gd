extends CharacterBody2D
class_name Enemy

const SPEED = 80

#@onready var screensize = get_viewport_rect().size
var limitTop
var limitBottom
var screenWidth
var half_screen_width

func _ready() -> void:
	var screenHeight = get_viewport_rect().size.y
	screenWidth = get_viewport_rect().size.x
	half_screen_width = screenWidth / 2
	var half_bar_height = $Size.shape.size.y / 2
	limitTop = half_bar_height
	limitBottom = screenHeight - half_bar_height

func _input(event: InputEvent) -> void:
	# Detectar arrastre táctil en la mitad derecha
	if event is InputEventScreenDrag:
		if event.position.x >= half_screen_width:
			# Mitad derecha: controla el enemigo
			position.y = clamp(event.position.y, limitTop, limitBottom)

func _physics_process(_delta: float) -> void:
	# Entrada del teclado (para desarrollo/pruebas)
	var direction := Input.get_axis("ui_up", "ui_down")
	velocity.y = direction * SPEED

	move_and_slide()
	
	position.y = clamp(position.y, limitTop, limitBottom)
