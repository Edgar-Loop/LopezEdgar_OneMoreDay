extends Node3D

class_name BuildManager

var store_menu

var player: CharacterBody3D
var game_manager: GameManager

var sell_mode := false
var sell_target: Node = null

var sell_progress := 0.0
const SELL_TIME := 1.0

var current_building: Node3D = null
var placing := false
var can_place := false

func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if sell_mode:
		handle_selling(delta)
		
	if placing and current_building:
		var pos = player.get_build_position()
		#current_building.global_position = pos
		current_building.global_position = player.get_build_position()
	if placing and !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		can_place = true
	if placing and can_place and Input.is_action_just_pressed("Place"):
		place_building()
	if placing and Input.is_action_just_pressed("Rotate"):
		current_building.rotate_y(deg_to_rad(90))

func set_ray_exceptions(node: Node, exclude: bool) -> void:
	if node is CollisionObject3D:
		if exclude:
			player.build_ray.add_exception(node)
		else:
			player.build_ray.remove_exception(node)

	for child in node.get_children():
		set_ray_exceptions(child, exclude)

func begin_placing(buildable_data: BuildableData) -> void:
	if current_building != null:
		return
	current_building = buildable_data.building_scene.instantiate()
	current_building.buildable_data = buildable_data
	print(current_building)
	get_tree().current_scene.add_child(current_building)
	set_ray_exceptions(current_building, true)
	await get_tree().physics_frame
	placing = true
	can_place = false

func place_building() -> void:
	set_ray_exceptions(current_building, false)
	if current_building == null:
		return
	placing = false
	current_building = null

func toggle_sell_mode() -> void:
	sell_mode = !sell_mode
	print(sell_mode)
	
func handle_selling(delta: float) -> void:
	if !player.build_ray.is_colliding():
		sell_progress = 0
		return

	var collider = player.build_ray.get_collider()
	sell_target = collider.owner
	print(sell_target)

	if Input.is_action_pressed("Sell"):
		sell_progress += delta

		if sell_progress >= SELL_TIME:
			game_manager.sell(sell_target.buildable_data.sell_price)
			store_menu.show_store_card(sell_target.buildable_data)

			sell_target.queue_free()

			sell_target = null
			sell_progress = 0
	else:
		sell_progress = 0
