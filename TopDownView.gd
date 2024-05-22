class_name TopDownView
extends Node2D

@export var MapScene: PackedScene

const GRID_SIZE_2D = 32

var dungeon_map

@onready var sprite_2d = $Sprite2D


func _ready():
	if not MapScene is PackedScene: return
	dungeon_map = MapScene.instantiate()
	add_child(dungeon_map)
	Globals.map = dungeon_map.get_hex_map()
	

func set_player(position: Vector2):
	sprite_2d.position.x = position.x * GRID_SIZE_2D
	sprite_2d.position.y = position.y * GRID_SIZE_2D


func get_hex_map() -> Array:
	return dungeon_map.get_hex_map()
