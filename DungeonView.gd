class_name DungeonView
extends Node3D

const CellScene = preload("res://Cell.tscn")

@onready var top_down_view: TopDownView = $TopDownView


func _ready():
	#var environment = WorldEnvironment
	#environment.background_mode = Environment.BG_COLOR
	#environment.background_color = Color.BLACK
	#environment.ambient_light_color = Color("432d6d")
	#environment.dof_blur_far_enabled = true
	#environment.dof_blur_near_enabled = true

	generate_map(top_down_view.get_hex_map())


func load_map_from_file(file_name: String) -> Array:
	var allthelines = []        

	var file = FileAccess.open(file_name, FileAccess.READ)
	while !file.eof_reached():
		var line = file.get_line()
		print(line)
		allthelines.append(line)
	file.close()
	return allthelines


func generate_map(map: Array):
	for y in map.size():
		for x in range(map[0].length()):
			var cell = create_cell(x, y)
			var walls = map[y][x]
			hide_walls(cell, walls)


func hide_walls(cell: Cell, walls: String):
	var hex = walls.hex_to_int()
	if hex & 0b0001 == 0:
		cell.northFace.hide()
	if hex & 0b0010 == 0:
		cell.eastFace.hide()
	if hex & 0b0100 == 0:
		cell.southFace.hide()
	if hex & 0b1000 == 0:
		cell.westFace.hide()


func create_cell(x: int, z: int) -> Cell:
	var cell = CellScene.instantiate()
	add_child(cell)
	cell.position = Vector3(x * Globals.GRID_SIZE, 0, z * Globals.GRID_SIZE)
	return cell


func _on_player_moved_player(new_position: Vector3):
	top_down_view.set_player(Vector2(new_position.x, new_position.z))
