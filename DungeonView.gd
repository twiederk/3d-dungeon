class_name DungeonView
extends Node3D

const GRID_SIZE_3D = 2

var hex_map: Array

@onready var first_person_view = $FirstPersonView
@onready var top_down_view: TopDownView = $TopDownView
@onready var player_3d = $Player3D


func _ready():
	#var environment = WorldEnvironment
	#environment.background_mode = Environment.BG_COLOR
	#environment.background_color = Color.BLACK
	#environment.ambient_light_color = Color("432d6d")
	#environment.dof_blur_far_enabled = true
	#environment.dof_blur_near_enabled = true
	hex_map = top_down_view.get_hex_map()
	first_person_view.generate_map(hex_map)


func _physics_process(_delta):
	player_3d.move(hex_map)


func _on_player_moved_player(new_position: Vector3):
	top_down_view.set_player(Vector2(new_position.x, new_position.z))
