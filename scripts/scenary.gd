extends Node2D


@export var enemy: PackedScene = preload("res://scenes/enemy.tscn")

func _ready() -> void:
	GLOBAL.score = 0
