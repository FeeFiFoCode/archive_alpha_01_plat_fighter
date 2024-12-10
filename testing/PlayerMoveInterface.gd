extends MoveInterface
class_name PlayerMove

enum HID {
	joypad,
	keyboard_left,
	keyboard_right,
	midi_keyboard,
	mouse
}

var currentHID = 0
var input_vector : Vector2

var input_buffer := []
var maxEntries := 120

var sensitivity = 1.5

# the most straighforward implementation
func addToBuffer(item):
	input_buffer.push_back(item)
	while input_buffer.size() > maxEntries:
		input_buffer.pop_front()


#
#const leftChordPresets = {
#	"Cmin7": [P0,P3,P7,P10],
#	"Cmin6": [P0,P3,P7,P8],
#	"CmM7" : [P0,P3,P7,P11],
#	"Ab7"  : [P0,P3,P6,P8]
#}

#const rightChordPresets = {
#	"Cmin7": [P0+12,P3+12,P7+12,P10+12],
#	"Cmin6": [P0+12,P3+12,P7+12,P8+12],
#	"CmM7" : [P0+12,P3+12,P7+12,P11+12],
#	"Ab7"  : [P0+12,P3+12,P6+12,P8+12]
#}

const leftChordPresets = {
	"Cmin7": [0,3,7,10],
	"Cmin6": [0,3,7,9],
	"CmM7" : [0,3,7,11],
	"Ab7"  : [0,3,6,8]
}

const rightChordPresets = {
	"Cmin7": [12,15,19,22],
	"Cmin6": [12,15,19,20],
	"CmM7" : [12,15,19,23],
	"Ab7"  : [12,15,18,20]
}

var leftChord = leftChordPresets["Cmin6"]
var rightChord = rightChordPresets["Cmin7"]

var midiCheck : bool
var midiVector : Vector2

func wants_jump(midiEvent) -> bool:
	midiCheck = false
	
	if midiEvent.message == 9:
		if midiEvent.pitch%24 == rightChord[0]:
			midiCheck = true
	return midiCheck

func wants_wave(midiEvent) -> bool:
	midiCheck = false
	
	if midiEvent.message == 9:
		if midiEvent.pitch%24 == rightChord[1]:
			midiCheck = true
			
		if midiEvent.pitch%24 == rightChord[2]:
			midiCheck = true
	return midiCheck

func midi_direction( midiEvent ) -> Vector2:
	addToBuffer( midiEvent )
	midiVector = Vector2(0,0)
	
	if midiEvent.message == 9:
		if midiEvent.pitch%24 == leftChord[0]:
			midiVector.x = -1*(midiEvent.velocity/127.0)
			
		if midiEvent.pitch%24 == leftChord[3]:
			midiVector.x = 1*(midiEvent.velocity/127.0)
			
	return midiVector
	
func is_direction_pressed( midiEvent ) -> bool:
	midiCheck = false
#	midiVector = Vector2(0,0)
	
	if midiEvent.message == 9:
		midiCheck = leftChord.has(midiEvent.pitch%24)
#		if midiEvent.pitch%24 == leftChord[0]:
#			midiCheck = true
#
#		if midiEvent.pitch%24 == leftChord[3]:
#			midiCheck = true
#	addToBuffer( midiVector )
	return midiCheck
	
func is_direction_released( midiEvent ) -> bool:
	midiCheck = false
#	midiVector = Vector2(0,0)
	
	if midiEvent.message == 8:
		midiCheck = leftChord.has(midiEvent.pitch%24)
#		if midiEvent.pitch%24 == leftChord[0]:
#			midiCheck = true
#
#		if midiEvent.pitch%24 == leftChord[3]:
#			midiCheck = true
#	addToBuffer( midiVector )
	return midiCheck
			
#func get_movement_direction_and_strength() -> Vector2:
#	match currentHID:
#		0:
#			print("Joypad")
#			input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#		1:
#			print("Keyboard Left")
#			input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#		2:
#			print("Keyboard Right")
#			input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#		3:
#			print("MIDI Keyboard")
#			input_vector = Vector2(0.1,0)
##			input_vector = _unhandled_input()
#			print(OS.get_connected_midi_inputs())
##			input_vector = _input(input_event):
##				if input_event is InputEventMIDI:
##					_print_midi_info(input_event
#			var process_midi = func _input(input_event):
#				if input_event is InputEventMIDI:
#					midiDirection(input_event)
#
#			input_vector =  process_midi.call()
#		4:
#			print("Mouse")
#			print("Mouse is not currently supportd.")
#		_:
#			print("The HID is uncrecognized.")
#	return input_vector
	
#func process_midi_keyboard(midi_event: InputEventMIDI):
#	# 24 Pitch Model
##	if midi_event.pitch%24 == leftChord[0]:
#
#	return null
#
#func midi_is_just_pressed( midiEvent: InputEventMIDI ) -> bool:
#	var midi_check = false
#	if midiEvent.message_event == 9:
#		midi_check = true
#
#	return midi_check
#func _unhandled_input(input_event):
#	if input_event is InputEventMIDI:
#		midiDirection(input_event)

#func midiDirection( midi_event : InputEventMIDI ) -> Vector2:
#
#
#	# 24 Pitch Model
#	var direction = Vector2(0,0)
##	print("Debug - MidiEvent Message: ",midi_event.message)
##	print("Debug - MidiEvent Pitch: ",midi_event.pitch%24)
#
#	if midi_event.message == 9:
##		print("Debug - Message - Bool Check: ",midi_event.message == 9)
#
#		if midi_event.pitch%24 == leftChord[0]:
#			direction.x = -1* ( midi_event.velocity/127.0 )
##			print("Debug - Direction.x: ",direction.x)
#
#		elif midi_event.pitch%24 == leftChord[3]:
#			direction.x = 1* ( midi_event.velocity/127.0 )
##			print("Debug - Direction.x: ",direction.x)
#		else:
#			pass
##	print("Debug - midiDirection:",direction)
#	return direction
#
##func _input(event : InputEvent ):
##	print(event.as_text ( ))
##	if(event.is_action_pressed("move_left")):
##		print(event.get_device())
#
#func _unhandled_input(input_event):
#	if input_event is InputEventMIDI:
#		_print_midi_info(input_event)
#
#func _print_midi_info(midi_event: InputEventMIDI):
#	print(midi_event)
#	print("Channel " + str(midi_event.channel))
#	print("Message " + str(midi_event.message))
#	print("Pitch " + str(midi_event.pitch))
#	print("Velocity " + str(midi_event.velocity))
#	print("Instrument " + str(midi_event.instrument))
#	print("Pressure " + str(midi_event.pressure))
#	print("Controller number: " + str(midi_event.controller_number))
#	print("Controller value: " + str(midi_event.controller_value))
#	print("\n")

