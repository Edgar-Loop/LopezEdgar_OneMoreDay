extends Control

@export var game_manager : GameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_pause", _on_game_manager_toggle_game_pause)

	
func _process(delta: float) -> void:
	pass

func _on_game_manager_toggle_game_pause(is_paused : bool):
	if (is_paused):
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_continue_pressed() -> void:
	game_manager.game_paused = false

func _on_main_menu_pressed() -> void:
	game_manager.game_paused = false
	print("step 2")
	get_tree().quit()
	#get_tree().change_scene_to_file("res://Scenes/pause_menu.tscn")
	
