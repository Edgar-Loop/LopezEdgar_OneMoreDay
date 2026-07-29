extends TextureRect

@export var store_menu: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	store_menu.toggle_store.connect(_on_store_menu_toggle_store)
	hide()

func _on_store_menu_toggle_store(is_opened : bool):
	print("Is Opened")
	if (is_opened):
		show()
	else:
		hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
