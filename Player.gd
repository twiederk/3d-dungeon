class_name Player
extends Node3D

enum Facing { North = 0, West = 90, South = 180, East = 270 }

var facing = Facing.North

@onready var timerprocessor: = $Timer
#@onready var tween: = $Tween
@onready var forward: = $RayForward
@onready var back: = $RayBack
@onready var right: = $RayRight
@onready var left: = $RayLeft


func _process(_delta):
	if Input.is_action_just_pressed("forward"):
		position += Vector3(Globals.GRID_SIZE, 0, 0)
	if Input.is_action_just_pressed("back"):
		position += Vector3(-Globals.GRID_SIZE, 0, 0)
	if Input.is_action_just_pressed("strafe_right"):
		position += Vector3(0, 0, Globals.GRID_SIZE)
	if Input.is_action_just_pressed("strafe_left"):
		position += Vector3(0, 0, -Globals.GRID_SIZE)
	if Input.is_action_just_pressed("turn_left"):
		facing = turnLeft()
	if Input.is_action_just_pressed("turn_right"):
		facing = turnRight()
	if Input.is_action_just_pressed("teleport_to_zero"):
		teleport_to_zero()


func turnLeft() -> int:
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


func turnRight() -> int:
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


func collision_check(direction):
	if direction != null:
		return direction.is_colliding()
	else:
		return false

func get_direction(direction):
	if not direction is RayCast3D: return
	return direction.get_collider().global_transform.origin - global_transform.origin

func tween_translation(_change):
	pass
	#$AnimationPlayer.play("Step")
	#tween.interpolate_property(
		#self, "translation", position, position + change,
		#0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	#)
	#tween.start()
	#await(tween, "tween_completed")

func tween_rotation(_change):
	pass
	#tween.interpolate_property(
		#self, "rotation", rotation, rotation + Vector3(0, change, 0),
		#0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	#)
	#tween.start()
	#yield(tween, "tween_completed")


func _on_Timer_timeout() -> void:
	var GO_W := Input.is_action_pressed("forward")
	var GO_S := Input.is_action_pressed("back")
	var GO_A := Input.is_action_pressed("strafe_left")
	var GO_D := Input.is_action_pressed("strafe_right")
	var TURN_Q := Input.is_action_pressed("turn_left")
	var TURN_E := Input.is_action_pressed("turn_right")

	var ray_dir
	var turn_dir = int(TURN_Q) - int(TURN_E)


	if GO_W:
		ray_dir = forward
	elif GO_S:
		ray_dir = back
	elif GO_A:
		ray_dir = left
	elif GO_D:
		ray_dir = right
	elif turn_dir:
		timerprocessor.stop()
		#yield(tween_rotation(PI/2 * turn_dir), "completed")
		timerprocessor.start()

	if collision_check(ray_dir):
		timerprocessor.stop()
		#yield(tween_translation(get_direction(ray_dir)), "completed")
		timerprocessor.start()
