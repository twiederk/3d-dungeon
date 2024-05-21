class_name Map
extends Node2D

@onready var tile_map = $TileMap

const LAYER = 0

const coords_to_hex_mapping = {
	Vector2(5, 2): "0",
	Vector2(1, 0): "1",
	Vector2(4, 2): "2",
	Vector2(2, 2): "3",
	Vector2(7, 1): "4",
	Vector2(4, 3): "5",
	Vector2(7, 0): "6",
	Vector2(4, 1): "7",
	Vector2(5, 1): "8",
	Vector2(0, 0): "9",
	Vector2(6, 0): "a",
	Vector2(1, 2): "b",
	Vector2(6, 1): "c",
	Vector2(5, 0): "d",
	Vector2(0, 3): "e",
	Vector2(6, 3): "f",
}


func get_hex_map() -> Array:
	var hex_map = Array()
	for y in range(4):
		var col = ""
		for x in range(4):
			var atlas_coords = tile_map.get_cell_atlas_coords(LAYER, Vector2(x, y))
			var hex = coords_to_hex(atlas_coords)
			col += hex
		hex_map.append(col)
	return hex_map


func coords_to_hex(coords: Vector2):
	return coords_to_hex_mapping[coords]
