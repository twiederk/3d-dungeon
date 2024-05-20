class_name Player2D
extends Node2D

const GRID_SIZE_2D = 64

func _process(_delta):
	if Input.is_action_just_pressed("forward"):
		position += Vector2(0, -GRID_SIZE_2D)
	if Input.is_action_just_pressed("back"):
		position += Vector2(0, GRID_SIZE_2D)
	if Input.is_action_just_pressed("strafe_left"):
		position += Vector2(-GRID_SIZE_2D, 0)
	if Input.is_action_just_pressed("strafe_right"):
		position += Vector2(GRID_SIZE_2D, 0)
