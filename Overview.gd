class_name Overview
extends Node2D

const TILE_SET_LAYER = 0
const TILE_SET_SOURCE_ID = 0

const hex_to_coords_mapping = {
	0: Vector2(5, 2),
	1: Vector2(1, 0),
	2: Vector2(4, 2),
	3: Vector2(2, 2),
	4: Vector2(7, 1),
	5: Vector2(4, 3),
	6: Vector2(7, 0),
	7: Vector2(4, 1),
	8: Vector2(5, 1),
	9: Vector2(0, 0),
	10: Vector2(6, 0),
	11: Vector2(1, 2),
	12: Vector2(6, 1),
	13: Vector2(5, 0),
	14: Vector2(0, 3),
	15: Vector2(6, 3),
}

@onready var tile_map = $TileMap


func _ready():
	var map = load_map()
	Globals.map = map
	generate_map(map)


func load_map() -> Array:
	var allthelines = []

	var file = FileAccess.open("res://maps/map3.txt", FileAccess.READ)
	while !file.eof_reached():
		var line = file.get_line()
		print(line)
		allthelines.append(line)
	file.close()
	return allthelines


func generate_map(map: Array):
	for y in map.size():
		for x in range(map[0].length()):
			var walls = map[y][x]
			var tile_id = hex_to_coords(walls.hex_to_int())
			# conver walls.hex() to vector in atlas
			# set tile on tilemap
			tile_map.set_cell(TILE_SET_LAYER, Vector2(x, y), TILE_SET_SOURCE_ID, tile_id)


func hex_to_coords(hex: int) -> Vector2:
	return hex_to_coords_mapping[hex]
