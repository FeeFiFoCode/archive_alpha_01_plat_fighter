extends State

@export
var fall_state : State
@export
var jump_state : State
@export
var move_state : State
@export
var waveGround_state : State

var input_dir
var midi_direction = Vector2(0.0, 0.0)
var direction
var previous_input

func enter() -> void:
	super()
#	parent.velocity.x = 0
#	parent.velocity.z = 0
#	print(parent.velocity.y)
	ctr_wave_air = CTR_WAVE_AIR
	ctr_jump = CTR_JUMP_MAX
	
	if move_component.input_buffer.size() > 0:
		previous_input = move_component.input_buffer[-1]
		if move_component.is_direction_pressed(previous_input):
			midi_direction = move_component.midi_direction

func process_input(event : InputEvent) -> State:
#	print("Debug: ",event)
	
	# Jump Logics
	if event is InputEventMIDI:
		if move_component.wants_jump(event) and parent.is_on_floor():
			return jump_state
	
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
		
	# Wave Logics
	if Input.is_action_just_pressed("wave_burst") and parent.is_on_floor():
		return waveGround_state
		
	if event is InputEventMIDI:
		if move_component.wants_wave(event) and parent.is_on_floor():
			return waveGround_state
	
	# Move Logics
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
#		input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#		direction = parent.transform.basis * Vector3(input_dir.x, 0, 0)
		return move_state
		
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
#		input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#		direction = parent.transform.basis * Vector3(input_dir.x, 0, 0)
		return move_state
		
	if event is InputEventMIDI:
		if move_component.midi_direction(event) and parent.is_on_floor():
			return move_state
			
	if event is InputEventMIDI:
		if move_component.is_direction_pressed(event) and parent.is_on_floor():
			midi_direction = move_component.midi_direction(event)
		
	return null


func process_physics( delta : float ) -> State:
#	print("Debug: Is Parent on Floor: ",parent.is_on_floor())
#	parent.velocity.y += gravity * delta
#	parent.move_and_slide()
#	print(parent.velocity.y)

	if not parent.is_on_floor():
		return fall_state
		
	if move_component.input_buffer.size() > 0:
		previous_input = move_component.input_buffer[-1]
		if move_component.is_direction_pressed(previous_input):
			return move_state
	
	print("Debug - idle_test.gd - Velocity is: ",parent.velocity)
#	else:
#		parent.velocity.x = move_toward(parent.velocity.x, 0, move_speed)
#		parent.velocity.y = move_toward(parent.velocity.y, 0, move_speed)
#		parent.velocity.z = move_toward(parent.velocity.z, 0, move_speed)
#
#		parent.move_and_slide()
	return null

func exit():
	input_dir = Vector2(0.0, 0.0)
	midi_direction = Vector2(0.0, 0.0)
