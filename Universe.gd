extends Node3D
class_name Universe

const CellScene = preload("res://Cell.tscn")

var cells = []

func _ready():
	pass
	#var environment = WorldEnvironment
	#environment.background_mode = Environment.BG_COLOR
	#environment.background_color = Color.BLACK
	#environment.ambient_light_color = Color("432d6d")
	#environment.dof_blur_far_enabled = true
	#environment.dof_blur_near_enabled = true
	generate_map()

func generate_map():
	cells.append(create_cell(0, 0))
	cells.append(create_cell(1, 0))
	cells.append(create_cell(0, 1))
	cells.append(create_cell(1, 1))
	
	cells[0].southFace.hide()
	cells[0].eastFace.hide()

	cells[1].southFace.hide()
	cells[1].westFace.hide()

	cells[2].northFace.hide()
	cells[2].eastFace.hide()
	
	cells[2].northFace.hide()
	cells[2].westFace.hide()
	
	
	#var map = MapScene.instantiate()
	#var tileMap = map.get_tilemap()
	#var used_tiles = tileMap.get_used_cells()
	#map.free() # We don't need it now that we have the tile data
	#for tile in used_tiles:
		#var cell = CellScene.instantiate()
		#add_child(cell)
		#cell.translation = Vector3(tile.x*Globals.GRID_SIZE, 0, tile.y*Globals.GRID_SIZE)
		#cells.append(cell)
	#for cell in cells:
		#cell.update_faces(used_tiles)


func create_cell(x: int, z: int) -> Cell:
	var cell = CellScene.instantiate()
	add_child(cell)
	cell.position = Vector3(x * Globals.GRID_SIZE, 0, z * Globals.GRID_SIZE)
	return cell

