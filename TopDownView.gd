class_name TopDownView
extends Node2D

@export var MapScene: PackedScene

const GRID_SIZE_2D = 32

@onready var sprite_2d = $Sprite2D


func _process(_delta):
	if Input.is_action_just_pressed("map"):
		visible = !visible

func set_player(new_position: Vector2):
	sprite_2d.position.x = new_position.x * GRID_SIZE_2D
	sprite_2d.position.y = new_position.y * GRID_SIZE_2D


func get_hex_map() -> Array[String]:
	var dungeon_map = MapScene.instantiate()
	add_child(dungeon_map)
	var hex_map = dungeon_map.get_hex_map()
	return hex_map
