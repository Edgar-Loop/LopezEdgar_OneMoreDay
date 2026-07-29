extends Label

@export var game_manager: GameManager

func _ready():
	show()
	game_manager.connect("toggle_game_pause", _on_game_manager_toggle_game_pause)
	game_manager.money_changed.connect(_on_money_changed)
	_on_money_changed(game_manager.money)
	
func _on_game_manager_toggle_game_pause(is_paused : bool):
	if (is_paused):
		hide()
	else:
		show()

func _on_money_changed(new_money: int):
	text = "$" + str(new_money)
