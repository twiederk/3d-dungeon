class_name ProcGenMap
extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

const cell_walls = {
	Vector2(1, 0): E,
	Vector2(-1, 0): W,
	Vector2(0, 1): S,
	Vector2(0, -1): N
}

const TILE_SET_LAYER_GROUND = 0
const TILE_SET_SOURCE_ID = 0

const width = 25  # width of map (in tiles)
const height = 15  # height of map (in tiles)

const coords_to_hex_mapping = {
	Vector2i(5, 2): 0,
	Vector2i(1, 0): 1,
	Vector2i(4, 2): 2,
	Vector2i(2, 2): 3,
	Vector2i(7, 1): 4,
	Vector2i(4, 3): 5,
	Vector2i(7, 0): 6,
	Vector2i(4, 1): 7,
	Vector2i(5, 1): 8,
	Vector2i(0, 0): 9,
	Vector2i(6, 0): 10,
	Vector2i(1, 2): 11,
	Vector2i(6, 1): 12,
	Vector2i(5, 0): 13,
	Vector2i(0, 3): 14,
	Vector2i(6, 3): 15,
}

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
	randomize()
	make_maze()


func check_neighbors(cell: Vector2, unvisited: Array) -> Array:
	# returns an array of cell's unvisited neighbors
	var list = []
	for cell_wall in cell_walls.keys():
		if cell + cell_wall in unvisited:
			list.append(cell + cell_wall)
	return list


func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []
	# fill the map with solid tiles
	tile_map.clear()
	for x in range(width):
		for y in range(height):
			var map_position = Vector2(x, y)
			unvisited.append(map_position)
			tile_map.set_cell(TILE_SET_LAYER_GROUND, map_position, TILE_SET_SOURCE_ID, hex_to_coords_mapping[15])
	var current = Vector2(0, 0)
	unvisited.erase(current)

	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			# remove walls from *both* cells
			var dir = next - current
			var current_walls = coords_to_hex_mapping[tile_map.get_cell_atlas_coords(TILE_SET_LAYER_GROUND, current)] - cell_walls[dir]
			var next_walls = coords_to_hex_mapping[tile_map.get_cell_atlas_coords(TILE_SET_LAYER_GROUND, next)] - cell_walls[-dir]
			tile_map.set_cell(TILE_SET_LAYER_GROUND, current, TILE_SET_SOURCE_ID, hex_to_coords_mapping[current_walls])
			tile_map.set_cell(TILE_SET_LAYER_GROUND, next, TILE_SET_SOURCE_ID, hex_to_coords_mapping[next_walls])
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()

