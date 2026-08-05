extends Control

class_name SellItem

signal buy_requested(scene, buildable_data)

@export var buildable_data: BuildableData
@export var building_scene: PackedScene

@export var card_frame: TextureRect
@export var icon: TextureRect
@export var name_label: Label
@export var price_label: Label

@export var game_manager: GameManager

var hovering: bool = false

func _ready() -> void:
	name_label.text = buildable_data.display_name
	price_label.text = "$" + str(buildable_data.buy_price)

	if buildable_data.icon:
		icon.texture = buildable_data.icon
		
	card_frame.mouse_entered.connect(_on_mouse_entered)
	card_frame.mouse_exited.connect(_on_mouse_exited)
	card_frame.gui_input.connect(_on_card_gui_input)

func _on_mouse_entered() -> void:
	#hovering = true
	card_frame.scale = Vector2(1.2, 1.2)

func _on_mouse_exited() -> void:
	#hovering = false
	card_frame.scale = Vector2.ONE

func _on_card_gui_input(event: InputEvent):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		if game_manager.buy(buildable_data.buy_price):
			hide()
			buy_requested.emit(building_scene, buildable_data)
