extends Node2D

@onready var map_creator = $MapCreator
@onready var tile_map = $TileMap

func get_tilemap():
	return tile_map
