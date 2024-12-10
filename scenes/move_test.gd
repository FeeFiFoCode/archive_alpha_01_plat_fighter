extends State

@export
var fall_state : State
@export
var jump_state : State
@export
var idle_state : State
@export
var waveGround_state : State

var input_dir = Vector2(0.0, 0.0)
var midi_direction = Vector2(0.0, 0.0)
var direction
var previous_input

func enter() -> void:
	super()
	
	if move_component.input_buffer.size() > 0:
		previous_input = move_component.input_buffer[-1]
		if move_component.is_direction_pressed(previous_input):
			midi_direction = move_component.midi_direction(previous_input)

func process_input(event : InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
#	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
#		return idle_state
	if event is InputEventMIDI:
		if move_component.wants_jump(event) and parent.is_on_floor():
			return jump_state
			
	if Input.is_action_just_pressed("wave_burst") and parent.is_on_floor():
		return waveGround_state

	if event is InputEventMIDI:
		if move_component.is_direction_pressed(event) and parent.is_on_floor():
			midi_direction = move_component.midi_direction(event)
			print("Debug - move_test.gd - process_input - midi_direction: ",midi_direction)
#
	if event is InputEventMIDI:
		if move_component.is_direction_released(event) and parent.is_on_floor():
			midi_direction = move_component.midi_direction(event)
	return null
	
func process_physics( delta : float ) -> State:
	print("Debug - move_test.gd - Velocity is: ",parent.velocity)
	
#	print("Debug - move_test.gd - midi_direction: ",midi_direction)
	if parent.is_on_floor():
#		# Terminal Velocity
##		velocity.y = maxf(velocity.y - gravity*delta, actual_velocity_terminal )
#		parent.velocity.y -= gravity*delta

		if move_component.currentHID == move_component.HID.midi_keyboard:
			input_dir = midi_direction*move_component.sensitivity
##### 	Temporarly commented to test move_component logic composition
#		if move_component.currentHID == move_component.HID.midi_keyboard:
#			input_dir = move_component.
#			pass
		if move_component.currentHID == move_component.HID.joypad:
			input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#		input_dir = move_component.get_movement_direction_and_strength()

		print("Debug - move_test.gd - input dir: ",input_dir)
		# direction = ( parent.transform.basis * Vector3(input_dir.x, 0, 0) ).normalize()
		direction = parent.transform.basis * Vector3(input_dir.x, 0, 0) * x_sensitivity
		
		print("Debug - move_test.gd - direction: ",direction)
		if direction:
			if direction.x < 0:
				facing_right = false
			else:
				facing_right = true
			print("Debug - Facing Right: ",facing_right)
#			lookdir = atan2(-parent.velocity.x, -parent.velocity.z)
#			parent.rotation.y = lookdir
			
			parent.velocity.x = direction.x * move_speed
		#	velocity.y = -direction.y * actual_speed
		#	velocity.z = direction.z * actual_speed
		else:
			parent.velocity.x = move_toward(parent.velocity.x, 0, traction)
			parent.velocity.z = move_toward(parent.velocity.z, 0, traction)
			return idle_state

#		parent.velocity.y += gravity * delta
		parent.move_and_slide()

	if not parent.is_on_floor():
		return fall_state
	return null

func exit():
	input_dir = Vector2(0.0, 0.0)
	midi_direction = Vector2(0.0, 0.0)
