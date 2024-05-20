extends GutTest

var overview: Overview = null


func before_each():
	overview = Overview.new()


func after_each():
	overview.free()


func test_should_cool_down_when_weapon_is_hot():
	# arrange

	# act
	var coords = overview.hex_to_coords(0)

	# assert
	assert_eq(coords, Vector2(5, 2))
