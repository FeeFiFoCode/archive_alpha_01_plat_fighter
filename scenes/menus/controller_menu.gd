extends Control

@onready var main = $".."
@onready var inputContract = $"../PlayableUnits/Player/InputContract"

@onready var contract_path = ""


func _on_return_pressed():
	main.controllerMenu()

func _on_gcc_pressed():
#	print("Debug: ",inputContract)
	contract_path = "res://scripts/controller_scripts/GamecubeContract.gd"
	SingletonInputContract.active_contract = contract_path
	inputContract.set_script(load(SingletonInputContract.active_contract))
	
	main.controllerMenu()


func _on_boxx_pressed():
	
	contract_path = "res://scripts/controller_scripts/BoxxContract.gd"
	SingletonInputContract.active_contract = contract_path
	inputContract.set_script(load(SingletonInputContract.active_contract))
	
	main.controllerMenu()


func _on_keyboard_pressed():	
	contract_path = "res://scripts/controller_scripts/KeyboardContract.gd"
	SingletonInputContract.active_contract = contract_path
	inputContract.set_script(load(SingletonInputContract.active_contract))
	
	main.controllerMenu()


func _on_midi_keyboard_pressed():
	contract_path = "res://scripts/controller_scripts/MidiKeyboardController.gd"
	SingletonInputContract.active_contract = contract_path
	inputContract.set_script(load(SingletonInputContract.active_contract))
	
	main.controllerMenu()


func _on_switch_pro_controller_pressed():	
	contract_path = "res://scripts/controller_scripts/SwitchProController.gd"
	SingletonInputContract.active_contract = contract_path
	inputContract.set_script(load(SingletonInputContract.active_contract))
	
	main.controllerMenu()
