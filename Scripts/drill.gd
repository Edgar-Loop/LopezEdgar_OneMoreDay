extends Node3D

class_name Drill

@export var ore_scene: PackedScene

@onready var output_point: Marker3D = $OutputPoint

@export var buildable_data: BuildableData

func _ready():
	var timer := Timer.new()
	timer.wait_time = 3.0
	timer.autostart = true
	timer.one_shot = false
	
	add_child(timer)

	timer.timeout.connect(_spawn_ore)


func interact():
	print("Drill activated!")
	
func _spawn_ore() -> void:
	if ore_scene == null:
		return

	var ore = ore_scene.instantiate()

	get_tree().current_scene.add_child(ore)

	ore.global_position = output_point.global_position
