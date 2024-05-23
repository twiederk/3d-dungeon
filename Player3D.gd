class_name Player3D
extends Node3D

signal moved_player(Vector3)

enum Facing { North = 0, West = 90, South = 180, East = 270 }

var facing: Facing = Facing.North


func move(hex_map: Array):
	if Input.is_action_just_pressed("forward"):
		move_forward(hex_map)
	#if Input.is_action_just_pressed("back"):
		#position += Vector3(-FirstPersonView.GRID_SIZE_3D, 0, 0)
	#if Input.is_action_just_pressed("strafe_right"):
		#position += Vector3(0, 0, FirstPersonView.GRID_SIZE_3D)
	#if Input.is_action_just_pressed("strafe_left"):
		#position += Vector3(0, 0, -FirstPersonView.GRID_SIZE_3D)
	if Input.is_action_just_pressed("turn_left"):
		facing = turn_left()
	if Input.is_action_just_pressed("turn_right"):
		facing = turn_right()
	if Input.is_action_just_pressed("teleport_to_zero"):
		teleport_to_zero()


func turn_left() -> Facing:
	if facing == Facing.North:
		facing = Facing.West
	elif facing == Facing.West:
		facing = Facing.South
	elif facing == Facing.South:
		facing = Facing.East
	elif facing == Facing.East:
		facing = Facing.North
	rotation.y = deg_to_rad(facing)
	return facing


func turn_right() -> Facing:
	if facing == Facing.North:
		facing = Facing.East
	elif facing == Facing.East:
		facing = Facing.South
	elif facing == Facing.South:
		facing = Facing.West
	elif facing == Facing.West:
		facing = Facing.North
	rotation.y = deg_to_rad(facing)
	return facing


func teleport_to_zero():
	position = Vector3.ZERO
	rotation = Vector3.ZERO
	facing = Facing.North
	moved_player.emit(position)


func move_forward(hex_map: Array):
	if collision_check(hex_map):
		return
	if facing == Facing.North:
		position += Vector3(0, 0, -FirstPersonView.GRID_SIZE_3D)
	elif facing == Facing.East:
		position += Vector3(FirstPersonView.GRID_SIZE_3D, 0, 0)
	elif facing == Facing.South:
		position += Vector3(0, 0, FirstPersonView.GRID_SIZE_3D)
	elif facing == Facing.West:
		position += Vector3(-FirstPersonView.GRID_SIZE_3D, 0, 0)
	moved_player.emit(position)


func collision_check(hex_map: Array) -> bool:
	var walls = hex_map[position.z / FirstPersonView.GRID_SIZE_3D][position.x / FirstPersonView.GRID_SIZE_3D]
	var hex = walls.hex_to_int()
	if facing == Facing.North:
		return hex & 0b0001 != 0
	if facing == Facing.East:
		return hex & 0b0010 != 0
	if facing == Facing.South:
		return hex & 0b0100 != 0
	if facing == Facing.West:
		return hex & 0b1000 != 0
	return true
