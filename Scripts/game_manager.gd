extends Node

class_name GameManager

@onready var player: CharacterBody3D = $MainGame/Player
@onready var build_manager: BuildManager = $BuildManager
@onready var store_menu = $Sidebuttons/StoreMenu

signal toggle_game_pause (is_paused : bool)
signal money_changed (new_money : int)

#signal build_mode_changed(enabled)
#signal sell_mode_changed(enabled)

#var build_mode := false
#var sell_mode := false

var money := 1000

var game_paused : = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_pause", game_paused)

func _ready():
	build_manager.player = player
	build_manager.game_manager = self
	build_manager.store_menu = store_menu

func _physics_process(delta):
	pass
	#print(player)

func can_afford(price: int) -> bool:
	return money >= price

func buy(price: int) -> bool:
	if can_afford(price):
		money -= price
		money_changed.emit(money)
		print("Bought item. Money left:", money)
		return true

	print("Not enough money!")
	return false

func sell(price: int):
	money += price
	money_changed.emit(money)
	print("Sold item. Money:", money)
		
func _input(event: InputEvent):
	if (event.is_action_pressed("Pause")):
		game_paused = !game_paused
		print("step 1")

#func begin_placing(buildable_data: BuildableData):
	#player.begin_placing(buildable_data)
