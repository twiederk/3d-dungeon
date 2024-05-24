class_name Player3D
extends Node3D

signal moved_player(Vector3)

enum Facing { North = 0, West = 90, South = 180, East = 270 }

const NORTH_WALL = 0b0001
const EAST_WALL = 0b0010
const SOUTH_WALL = 0b0100
const WEST_WALL = 0b1000

var facing: Facing = Facing.North


func move(hex_map: Array):
	if Input.is_action_just_pressed("forward"):
		move_forward(hex_map)
	if Input.is_action_just_pressed("back"):
		move_back(hex_map)
	#if Input.is_action_just_pressed("strafe_right"):
		#position += Vector3(0, 0, FirstPersonView.GRID_SIZE_3D)
	#if Input.is_action_just_pressed("strafe_left"):
		#position += Vector3(0, 0, -FirstPersonView.GRID_SIZE_3D)
	if Input.is_action_just_pressed("turn_left"):
		turn_left()
	if Input.is_action_just_pressed("turn_right"):
		turn_right()
	if Input.is_action_just_pressed("teleport_to_zero"):
		teleport_to_zero()


func turn_left():
	if facing == Facing.North:
		facing = Facing.West
	elif facing == Facing.West:
		facing = Facing.South
	elif facing == Facing.South:
		facing = Facing.East
	elif facing == Facing.East:
		facing = Facing.North
	rotation.y = deg_to_rad(facing)


func turn_right():
	if facing == Facing.North:
		facing = Facing.East
	elif facing == Facing.East:
		facing = Facing.South
	elif facing == Facing.South:
		facing = Facing.West
	elif facing == Facing.West:
		facing = Facing.North
	rotation.y = deg_to_rad(facing)


func teleport_to_zero():
	position = Vector3.ZERO
	rotation = Vector3.ZERO
	facing = Facing.North
	moved_player.emit(position)


func move_forward(hex_map: Array):
	if facing == Facing.North and not check_collision(hex_map, Facing.North):
		position += Vector3(0, 0, -FirstPersonView.GRID_SIZE_3D)
	elif facing == Facing.East and not check_collision(hex_map, Facing.East):
		position += Vector3(FirstPersonView.GRID_SIZE_3D, 0, 0)
	elif facing == Facing.South and not check_collision(hex_map, Facing.South):
		position += Vector3(0, 0, FirstPersonView.GRID_SIZE_3D)
	elif facing == Facing.West and not check_collision(hex_map, Facing.West):
		position += Vector3(-FirstPersonView.GRID_SIZE_3D, 0, 0)
	moved_player.emit(position)


func move_back(hex_map: Array):
	if facing == Facing.North and not check_collision(hex_map, Facing.South):
		position += Vector3(0, 0, FirstPersonView.GRID_SIZE_3D)
	elif facing == Facing.East and not check_collision(hex_map, Facing.West):
		position += Vector3(-FirstPersonView.GRID_SIZE_3D, 0, 0)
	elif facing == Facing.South and not check_collision(hex_map, Facing.North):
		position += Vector3(0, 0, -FirstPersonView.GRID_SIZE_3D)
	elif facing == Facing.West and not check_collision(hex_map, Facing.East):
		position += Vector3(FirstPersonView.GRID_SIZE_3D, 0, 0)
	moved_player.emit(position)


func check_collision(hex_map: Array, direction: Facing) -> bool:
	var walls = hex_map[position.z / FirstPersonView.GRID_SIZE_3D][position.x / FirstPersonView.GRID_SIZE_3D]
	var hex = walls.hex_to_int()
	if direction == Facing.North:
		return has_wall(hex, NORTH_WALL)
	if direction == Facing.East:
		return has_wall(hex, EAST_WALL)
	if direction == Facing.South:
		return has_wall(hex, SOUTH_WALL)
	if direction == Facing.West:
		return has_wall(hex, WEST_WALL)
	return true


func has_wall(hex: int, wall: int) -> bool:
	return hex & wall != 0
