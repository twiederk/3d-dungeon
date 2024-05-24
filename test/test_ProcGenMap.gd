extends GutTest


var proc_gen_map : ProcGenMap = null

func before_each():
	proc_gen_map = ProcGenMap.new()


func after_each():
	proc_gen_map.free()


func test_can_instanciate():

	# act
	var hex = proc_gen_map.coords_to_hex_mapping[Vector2i(6, 3)]

	# assert
	assert_eq(hex, 15)
