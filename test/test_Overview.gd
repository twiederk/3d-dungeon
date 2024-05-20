extends GutTest

var overview: Overview = null

func before_each():
	overview = Overview.new()


func after_each():
	overview.free()
	

func test_should_cool_down_when_weapon_is_hot():
	# arrange

	# act

	# assert
	assert_true(true)
