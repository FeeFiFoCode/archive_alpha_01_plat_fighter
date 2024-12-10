extends State

@export
var fall_state : State
@export
var idle_state : State
@export
var move_state : State

@export
var jump_force : float = 30.0

var input_dir
var midi_direction = Vector2(0.0, 0.0)
var direction
var previous_input

func enter() -> void:
	super()
	parent.velocity.y = jump_force
	
func exit() -> void:
	super()
	input_dir = Vector2(0.0, 0.0)
	midi_direction = Vector2(0.0, 0.0)

func process_input(event : InputEvent) -> State:
	print("Debug - jump_test.gd - process_input - Basic Check.")
	if event is InputEventMIDI:
		print("Debug - jump_test.gd - process_input - Level 2")
		
		if move_component.is_direction_pressed(event) and not parent.is_on_floor():
			print("Debug - jump_test.gd - process_input - Level 3.1")
			midi_direction = move_component.midi_direction(event)
			print("Debug - jump_test.gd - process_input - midi_direction: ",midi_direction)
#		
		elif move_component.is_direction_released(event) and not parent.is_on_floor():
			print("Debug - jump_test.gd - process_input - Level 3.2")
			midi_direction = move_component.midi_direction(event)
	return null

func process_physics(delta : float ) -> State:
#	print("Debug - jump_test - velocity.y: ",parent.velocity.y)
	parent.velocity.y -= gravity
	
	if parent.velocity.y <= 0:
		return fall_state
		
	if move_component.currentHID == move_component.HID.midi_keyboard:
			input_dir = midi_direction*move_component.sensitivity
	
	if move_component.currentHID == move_component.HID.joypad:
			input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			
	direction = parent.transform.basis * Vector3(input_dir.x, 0, 0) * x_sensitivity
	
	parent.velocity.x = direction.x * air_speed
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if direction != 0:
			return move_state
		else:
			return idle_state
			
	return null
