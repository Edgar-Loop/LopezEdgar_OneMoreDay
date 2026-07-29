extends MeshInstance3D

@onready var animation_player: AnimationPlayer = $"../NurbsPath-col/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Drilling")
