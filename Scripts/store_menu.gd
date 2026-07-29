extends Control

@export var game_manager : GameManager
@export var build_manager: BuildManager

@onready var store_items: HBoxContainer = $TextureRect/StoreItems

var _store_opened := false

signal toggle_store (is_opened : bool)

func _ready():
	show()
	game_manager.connect("toggle_game_pause", _on_game_manager_toggle_game_pause)
	for child in store_items.get_children():
		print(child.name, " ", child)
		if child is SellItem:
			child.game_manager = game_manager
			child.buy_requested.connect(_on_buy_requested)

func _on_buy_requested(scene: PackedScene):
	store_opened = false

	build_manager.begin_placing(scene)

func _process(delta: float) -> void:
	pass

func _on_game_manager_toggle_game_pause(is_paused : bool):
	if (is_paused):
		hide()
	else:
		show()

var store_opened: bool:
	get:
		return _store_opened
	set(value):
		_store_opened = value
		emit_signal("toggle_store", _store_opened)

func _on_store_pressed() -> void:
	print("store")
	store_opened = !store_opened
