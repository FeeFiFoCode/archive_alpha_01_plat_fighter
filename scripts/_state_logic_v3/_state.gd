extends Node
class_name _State


var stickMap = []


# Hold Reference to Parent so it can be controlled by the state
var parent : CharacterBody3D
var input

@export
var animation_name : String


# Helper Var & Functions
var is_debug = true

func debug(msg) -> void:
	if is_debug:
		print("Debug -",name,":",msg)
	else:
		pass
		

# Key State Functions

## On Entry to State
func enter() -> void:
# No Animation Here
##	parent.animations.play(animation_name)
	if animation_name:
		parent.animations.play(animation_name)
	else:
		parent.animations.play("poseT")
		debug("No animation")
	
	print("Just entered: ",name)
#	print(Vector2( Input.get_joy_axis(0,JOY_AXIS_LEFT_X), -1*Input.get_joy_axis(0,JOY_AXIS_LEFT_Y) ))
	pass

## On Exit of State
func exit() -> void:
	print("Just exited: ",name)
	pass

func process_input(event : InputEvent ) -> _State:
	if input.controller_type == "MIDI_Keybord":
		if event is InputEventMIDI:
			print("Debug - _State.gd: controller_type:",input.controller_type)
			input.process_midi(event)
		else:
			pass
		
	else:
		pass
		
	return null

func process_frame(delta : float ) -> _State:
	return null
	
func process_physics( delta : float ) -> _State:
	return null
