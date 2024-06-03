class_name TextMap
extends Node


func get_hex_map() -> Array[String]:
	return load_map_from_file("res://maps/map3.txt")


func load_map_from_file(file_name: String) -> Array[String]:
	var allthelines = []        
	var file = FileAccess.open(file_name, FileAccess.READ)
	while !file.eof_reached():
		var line = file.get_line()
		print(line)
		allthelines.append(line)
	file.close()
	return allthelines

