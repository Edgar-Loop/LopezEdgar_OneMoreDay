extends Node3D

@onready var area: Area3D = $Area3D

@export var speed := 3.0

@export var buildable_data: BuildableData

func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta):
	for body in area.get_overlapping_bodies():
		print(body.name)

		if body is CharacterBody3D:
			body.velocity += -global_transform.basis.z * speed
