extends Node3D

class_name BuildManager

var player: CharacterBody3D

var current_building: Node3D = null
var placing := false
var can_place := false

func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if placing and current_building:
		var pos = player.get_build_position()
		current_building.global_position = pos
		current_building.global_position = player.get_build_position()
	if placing and !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		can_place = true
	if placing and can_place and Input.is_action_just_pressed("Place"):
		place_building()
	if placing and Input.is_action_just_pressed("Rotate"):
		current_building.rotate_y(deg_to_rad(90))

func begin_placing(scene: PackedScene) -> void:
	if current_building != null:
		return
	current_building = scene.instantiate()
	print(current_building)
	get_tree().current_scene.add_child(current_building)
	player.build_ray.add_exception(current_building)
	await get_tree().physics_frame
	placing = true
	can_place = false

func place_building() -> void:
	player.build_ray.remove_exception(current_building)
	if current_building == null:
		return
	placing = false
	current_building = null
