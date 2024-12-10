extends InputContract

# Controller Type ( varies for other controllers )
#var controller_type = "Keyboard"

# MIDI Input Modes
## Velocity-Based
## Dedicated Modifier Buttons
## Hybird of Velocity and Modifiers
## Dedicated Buttons of Varying Analog Strengths
var controller_type = "MIDI_Keybord"

var contract_name = "MIDI Keyboard"
var debugString = "Debug: " + contract_name

enum MODES {
	VELOCITY,
	MODIFIER,
	HYBIRD,
	MULTI
}

var active_mode = MODES.VELOCITY

# Input Presets - Chords
## Temporary approach for indexing notes' pitch values
const PRESETS_LEFT = {
	"Cmin7": [0,3,7,10],
	"Cmin6": [0,3,7,9],
	"CmM7" : [0,3,7,11],
	"Ab7"  : [0,3,6,8]
}

var active_left = "Cmin7"
var num_left_amt = len(PRESETS_LEFT[active_left])

const PRESETS_RIGHT = {
	"Cmin7": [12,15,19,22],
	"Cmin6": [12,15,19,20],
	"CmM7" : [12,15,19,23],
	"Ab7"  : [12,15,18,20]
}

var active_right = "Cmin7"
var num_right_amt = len(PRESETS_RIGHT[active_right])

# Create Local Input Storage to Track Buttons' States & Velocities
#enum { IS_PRESSED, BTN_VELOCITY }

var input_tracking_left = [
	Vector2(false,0.0),
	Vector2(false,0.0),
	Vector2(false,0.0),
	Vector2(false,0.0) ]

var input_tracking_right = [
	Vector2(false,0.0),
	Vector2(false,0.0),
	Vector2(false,0.0),
	Vector2(false,0.0) ]

enum LS { LEFT, DOWN, UP, RIGHT }

enum BTN { STATE, VEL}

# MIDI Input Processing
func process_midi(midiEvent) -> void:
	print(debugString,"Process MIDI: ",midiEvent)
#	var input_is_valid = false
	
	if midiEvent.message == 9:
		input_on(midiEvent)

	if midiEvent.message == 8:
		input_off(midiEvent)

			
	if (midiEvent.message != 9 ) and (midiEvent.message != 8):
			print(debugString," - Invalid MIDI Input: ", midiEvent)
	
	pass
	
func input_on(midiEvent) -> void:
	for ctr in range (num_left_amt):
		if midiEvent.pitch%24 == PRESETS_LEFT[active_left][ctr]:
			input_tracking_left[ctr] = Vector2(1,midiEvent.velocity)
			print(debugString,"Current Input Tracking: ",input_tracking_left[ctr])
#			input_is_valid = true
			
	for ctr in range (num_right_amt):
		if midiEvent.pitch%24 == PRESETS_RIGHT[active_left][ctr]:
			input_tracking_right[ctr] = Vector2(1,midiEvent.velocity)
#			input_is_valid = true
			
#	if not input_is_valid:
#		print(debugString," - Invalid MIDI Input: ", midiEvent)
			
	pass

func input_off(midiEvent) -> void:
	for ctr in range (num_left_amt):
			if midiEvent.pitch%24 == PRESETS_LEFT[active_left][ctr]:
				input_tracking_left[ctr] = Vector2(0,0)
#				input_is_valid = true
				
	for ctr in range (num_right_amt):
		if midiEvent.pitch%24 == PRESETS_RIGHT[active_left][ctr]:
			input_tracking_right[ctr] = Vector2(0,0)
#			input_is_valid = true
				
#	if not input_is_valid:
#		print(debugString," - Invalid MIDI Input: ", midiEvent)
	
	pass
##
#
#	# Handling Left Horizontal
#
#	if Input.is_action_pressed("move_left") or Input.is_action_just_released("move_left"):
#		left_x = -1
#	elif Input.is_action_pressed("move_right") or Input.is_action_just_released("move_right"):
#		left_x = 1
#	else:
#		left_x = 0
#
#	pass

#	# Jump Logics
#	if event is InputEventMIDI:
#		if move_component.wants_jump(event) and parent.is_on_floor():
#			return jump_state
#
#	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
#		return jump_state


#
## Input Sensitivity for Analog Inputs
### Left Stick
#### Sensitivities
#var sensitivity_left_stick = 1.0
#var sensitivity_left_stick_x = sensitivity_left_stick
#var sensitivity_left_stick_y = sensitivity_left_stick
#
### Signal Handling
#var left_x
#var left_y
#
#var sensitivity_right_stick = 1.0
#var sensitivity_right_stick_x = sensitivity_right_stick
#var sensitivity_right_stick_y = sensitivity_right_stick
#
#var sensitivity_left_trigger = 1.0
#var sensitivity_right_trigger = 1.0

var mod_x = 0.5
var mod_y = 0.5

# Get Regions
func get_region_left_stick() -> Vector2:
	# Handling Left Horizontal
	if active_mode == MODES.VELOCITY:
#		print(debugString,"Get LS - Is active_mode == modes.velocity: ")

		## If Input Left gives LEFT, then turn off RIGHT
		if input_tracking_left[LS.LEFT][BTN.STATE]==1:
			left_x = input_tracking_left[LS.LEFT][BTN.VEL]/127.0
			left_x *= -1
			
			print(debugString,"Input Tracking - LS LEFT, BTN.STATE: ",input_tracking_left[LS.LEFT][BTN.STATE])
#			input_tracking_left[LS.RIGHT][BTN.STATE] = false
			input_tracking_left[LS.RIGHT][BTN.STATE] = 0
		
		## If Input Left gives RIGHT, then turn off LEFT
		if input_tracking_left[LS.RIGHT][BTN.STATE]==1:
			left_x = input_tracking_left[LS.RIGHT][BTN.VEL]/127.0
			print(debugString,"Input Tracking - LS RIGHT, BTN.STATE: ",input_tracking_left[LS.RIGHT][BTN.STATE])
#			input_tracking_left[LS.LEFT][BTN.STATE] = false
			input_tracking_left[LS.LEFT][BTN.STATE] = 0

		if input_tracking_left[LS.LEFT][BTN.STATE]==0:
			if input_tracking_left[LS.RIGHT][BTN.STATE]==0:
				left_x = 0
	
	# Handling Left Vertical
	if active_mode == MODES.VELOCITY:

		## If Input Left gives UP, then turn off DOWN
		if input_tracking_left[LS.UP][BTN.STATE]==1:
			left_y = input_tracking_left[LS.UP][BTN.VEL]/127.0
			left_y *= -1
			
			print(debugString,"Input Tracking - LS UP, BTN.STATE: ",input_tracking_left[LS.UP][BTN.STATE])
#			input_tracking_left[LS.RIGHT][BTN.STATE] = false
			input_tracking_left[LS.DOWN][BTN.STATE] = 0
		
		## If Input Left gives DOWN, then turn off UP
		if input_tracking_left[LS.DOWN][BTN.STATE]==1:
			left_y = input_tracking_left[LS.DOWN][BTN.VEL]/127.0
			print(debugString,"Input Tracking - LS DOWN, BTN.STATE: ",input_tracking_left[LS.DOWN][BTN.STATE])
#			input_tracking_left[LS.LEFT][BTN.STATE] = false
			input_tracking_left[LS.UP][BTN.STATE] = 0

		if input_tracking_left[LS.UP][BTN.STATE]==0:
			if input_tracking_left[LS.DOWN][BTN.STATE]==0:
				left_y = 0
			
	left_x *= sensitivity_left_stick_x
	
	if left_x > 1:
		left_x = 1
	elif left_x < -1:
		left_x = -1
	else:
		pass
		
	left_y *= sensitivity_left_stick_y
	left_y *= -1

	if left_y > 1:
		left_y = 1
	elif left_y < -1:
		left_y = -1
	else:
		pass
		
	return Vector2(left_x,left_y)


