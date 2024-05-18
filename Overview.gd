class_name Overview
extends Node2D

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
			pass
			# conver walls.hex() to vector in atlas
			# set tile on tilemap
			# tilemap.set_cell(TILE_SET_LAYER_GROUND, map_position, TILE_SET_SOURCE_ID, TILE_FENCE)
