extends Node3D

enum PitchClass {
	P0,
	P1,
	P2,
	P3,
	P4,
	P5,
	P6,
	P7,
	P8,
	P9,
	P10,
	P11,
	P12,
	P13,
	P14,
	P15,
	P16,
	P17,
	P18,
	P19,
	P20,
	P21,
	P22,
	P23
}

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())
#	print(PitchClass.P8)
	
#func _input(event : InputEvent ):
#	print(event.as_text ( ))
#	if(event.is_action_pressed("move_left")):
#		print(event.get_device())

func _input(input_event):
	if input_event is InputEventMIDI:
		_print_midi_info(input_event)

func _print_midi_info(midi_event: InputEventMIDI):
	print(midi_event)
	print("Channel " + str(midi_event.channel))
	print("Message " + str(midi_event.message))
	print("Pitch " + str(midi_event.pitch))
	print("Velocity " + str(midi_event.velocity))
	print("Instrument " + str(midi_event.instrument))
	print("Pressure " + str(midi_event.pressure))
	print("Controller number: " + str(midi_event.controller_number))
	print("Controller value: " + str(midi_event.controller_value))
	print("\n")

#func _find_midi_pitch_class(midi_event : InputEventMIDI ):
	
