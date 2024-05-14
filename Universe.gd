extends Node3D
class_name Universe

const CellScene = preload("res://Cell.tscn")
const MapScene = preload("res://Map.tscn")

@onready var map = $Map

var cells = []

func _ready():
	pass
	#var environment = WorldEnvironment
	#environment.background_mode = Environment.BG_COLOR
	#environment.background_color = Color.BLACK
	#environment.ambient_light_color = Color("432d6d")
	#environment.dof_blur_far_enabled = true
	#environment.dof_blur_near_enabled = true
	#generate_map()

func generate_map():
	#var map = MapScene.instantiate()
	var tileMap = map.get_tilemap()
	print("tileMap: ", tileMap)
	var used_tiles = tileMap.get_used_cells()
	map.free() # We don't need it now that we have the tile data
	for tile in used_tiles:
		var cell = CellScene.instantiate()
		add_child(cell)
		cell.translation = Vector3(tile.x*Globals.GRID_SIZE, 0, tile.y*Globals.GRID_SIZE)
		cells.append(cell)
	for cell in cells:
		cell.update_faces(used_tiles)
