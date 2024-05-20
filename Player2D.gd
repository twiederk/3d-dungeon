class_name Player2D
extends Node2D

const GRID_SIZE_2D = 64

const DIR_NORTH = Vector2(0, -GRID_SIZE_2D)
const DIR_SOUTH = Vector2(0, GRID_SIZE_2D)
const DIR_WEST = Vector2(-GRID_SIZE_2D, 0)
const DIR_EAST = Vector2(GRID_SIZE_2D, 0)


func _process(_delta):
	if Input.is_action_just_pressed("forward"):
		if is_blocked(DIR_NORTH):
			position += DIR_NORTH
	if Input.is_action_just_pressed("back"):
		if is_blocked(DIR_SOUTH):
			position += DIR_SOUTH
	if Input.is_action_just_pressed("strafe_left"):
		if is_blocked(DIR_WEST):
			position += DIR_WEST
	if Input.is_action_just_pressed("strafe_right"):
		if is_blocked(DIR_EAST):
			position += DIR_EAST
		

func is_blocked(direction: Vector2) -> bool:
	var walls = Globals.map[position.y / GRID_SIZE_2D][position.x / GRID_SIZE_2D]
	var hex = walls.hex_to_int()
	print(walls)
	if direction == DIR_NORTH:
		return hex & 0b0001 == 0
	if direction == DIR_EAST:
		return hex & 0b0010 == 0
	if direction == DIR_SOUTH:
		return hex & 0b0100 == 0
	if direction == DIR_WEST:
		return hex & 0b1000 == 0
	return true
