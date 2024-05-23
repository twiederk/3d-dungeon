class_name FirstPersonView
extends Node3D

const CellScene = preload("res://Cell.tscn")


func generate_map(map: Array, grid_size: int):
	for y in map.size():
		for x in range(map[0].length()):
			var cell = create_cell(x, y, grid_size)
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


func create_cell(x: int, z: int, grid_size: int) -> Cell:
	var cell = CellScene.instantiate()
	add_child(cell)
	cell.position = Vector3(x * grid_size, 0, z * grid_size)
	return cell
