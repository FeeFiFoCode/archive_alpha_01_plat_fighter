class_name StageLogic 
extends Node

enum DIR { TOP, RIGHT, DOWN, LEFT }
var blastZones = [
	100.0,
	300.0/2 + 50.0,
	-30.0,
	-1*(300.0/2 + 50.0)
	]

@onready
var player = $PlayableUnits/Player

@onready
var pause_menu = $PauseMenu
var is_paused = false

@onready
var controller_menu = $ControllerMenu
var is_controller_menu = false

var stageName = "Testing Zone"
var debugString = "Debug -- " + stageName
var reset = false


func _process( delta ):
	if Input.is_action_just_pressed("start"):
		pauseMenu()
		
func pauseMenu():
	if is_paused:
		pause_menu.hide()
		Engine.time_scale = 1
#		get_tree().paused = false
	else:
		pause_menu.show()
#		Engine.time_scale goooggggfksjfdslkfjsdklfsdfs 0
#		get_tree().paused = true
		
	is_paused = not is_paused
	
func controllerMenu():
	if is_controller_menu:
		pause_menu.show()
		controller_menu.hide()
	
	else:
		pause_menu.hide()
		controller_menu.show()
	
	is_controller_menu = not is_controller_menu
	

func _physics_process(delta: float) -> void:
#	print(debugString, player.position )
	reset = false
	
	if player.position.x >= blastZones[DIR.RIGHT]:
		print(debugString, player.position)
		print(debugString,"Player hit RIGHT")
		reset = true
		
	elif player.position.x <= blastZones[DIR.LEFT]:
		print(debugString, player.position )
		print(debugString,"Player hit LEFT")
		reset = true
		
	else:
		pass
		
	if player.position.y >= blastZones[DIR.TOP]:
		print(debugString, player.position)
		print(debugString,"Player hit TOP")
		reset = true
		
	elif player.position.y <= blastZones[DIR.DOWN]:
		print(debugString, player.position)
		print(debugString,"Player hit DOWN")
		reset = true
		
	else:
		pass
		
	if reset:
		get_tree().change_scene_to_file("res://scenes/stages/Testing_Zone/Testing_Zone.tscn")
	else:
		pass
#	state_machine_attack.process_physics(delta)
