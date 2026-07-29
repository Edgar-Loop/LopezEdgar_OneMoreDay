@tool
extends Node3D

@export var gridWidth := 5:
	set(value):
		gridWidth = value
		_remove_grid()
		_create_grid()
@export var gridHeight := 5:
	set(value):
		gridHeight = value
		_remove_grid()
		_create_grid()
@export var cellSize:Vector2 = Vector2(1,1):
	set(value):
		cellSize = value
		_remove_grid()
		_create_grid()
@export var defaultColor: Color = Color.GRAY

const GRID_CELL = preload("res://Scenes/grid_cell.tscn")

func _remove_grid():
	for node in get_children():
		node.queue_free()
	
func _create_grid():
	for height in range(gridHeight):
		for width in range(gridWidth):
			var gridcell = GRID_CELL.instantiate()
			gridcell.cellSize = cellSize
			
			add_child(gridcell)
			
			var offset = Vector3(width * cellSize.x, 0, height * cellSize.y)
			gridcell.global_position = global_position + offset
