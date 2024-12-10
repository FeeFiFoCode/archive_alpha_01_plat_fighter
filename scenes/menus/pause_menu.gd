extends Control


@onready var main = $".."

func _on_resume_pressed():
	main.pauseMenu()

func _on_controller_menu_pressed():
	main.controllerMenu()

func _on_exit_game_pressed():
	get_tree().quit()



