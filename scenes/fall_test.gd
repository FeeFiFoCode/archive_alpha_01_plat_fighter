extends State

@export
var idle_state : State
@export
var move_state : State
@export
var landed_state : State
@export
var waveAir_state : State

var input_dir = Vector2(0.0, 0.0)
var midi_direction = Vector2(0.0, 0.0)
var direction
var previous_input

func enter():
	super()
#	print("DEBUG - from Fall - Jumps Remaining:",ctr_jump)
	if move_component.input_buffer.size() > 0:
		previous_input = move_component.input_buffer[-1]
		if move_component.is_direction_pressed(previous_input):
			midi_direction = move_component.midi_direction(previous_input)

func process_input(event : InputEvent) -> State:
	print("Debug - fall_test.gd - process_input - Basic Check.")
	if Input.is_action_just_pressed("wave_burst") and not parent.is_on_floor():
		if ctr_wave_air > 0:
			return waveAir_state
			
	if event is InputEventMIDI:
		if move_component.wants_wave(event) and not parent.is_on_floor():
			if ctr_wave_air > 0:
				return waveAir_state
				
	if event is InputEventMIDI:
		if move_component.is_direction_pressed(event) and not parent.is_on_floor():
			midi_direction = move_component.midi_direction(event)
#			print("Debug - fall_test.gd - process_input - midi_direction: ",midi_direction)
#
	if event is InputEventMIDI:
		if move_component.is_direction_released(event) and not parent.is_on_floor():
			midi_direction = move_component.midi_direction(event)
			
	return null

func process_physics(delta : float ) -> State:
	if not parent.is_on_floor():
		# Terminal Velocity
		parent.velocity.y = maxf(parent.velocity.y - gravity_falling*delta, velocity_air_terminal )
#		parent.velocity.y -= gravity*delta

#		if Input.is_action_just_pressed("jump") and not parent.is_on_floor():
#			if ctr_jump > 0:
#				ctr_jump -= 1
#				parent.velocity.y = force_jump_air
		if move_component.currentHID == move_component.HID.midi_keyboard:
			input_dir = midi_direction*move_component.sensitivity
##### 	Temporarly commented to test move_component logic composition
#		if move_component.currentHID == move_component.HID.midi_keyboard:
#			input_dir = move_component.
#			pass
		if move_component.currentHID == move_component.HID.joypad:
			input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

		direction = parent.transform.basis * Vector3(input_dir.x, 0, 0) * x_sensitivity
		
		if direction:
			# DEPRECATED - Don't change direction in air?
#			if direction.x < 0:
#				facing_right = false
#			else:
#				facing_right = true
#			print("Debug - Facing Right: ",facing_right)
			
			parent.velocity.x = direction.x * air_speed
			
#			lookdir = atan2(-parent.velocity.x, -parent.velocity.z)
#			parent.rotation.y = lookdir
		#	velocity.y = -direction.y * actual_speed
		#	velocity.z = direction.z * actual_speed
		else:
			parent.velocity.x = move_toward(parent.velocity.x, 0, air_speed)
			parent.velocity.z = move_toward(parent.velocity.z, 0, air_speed)
				
	#	var movement = Input.get_axis("move_left","move_right") * air_speed
		
	#	parent.velocity.x = movement
	#	parent.move_and_slide()
		parent.move_and_slide()
	
# Pausing this approach for now.
# Going to try just if on floor send to landing state.
# Then from there they can do the whole move or idle thing.
#
#	if parent.is_on_floor():
##		print("DEBUG: ","Reached is on floor")
#		if direction:
#			return move_state
#		else:
#			return idle_state
			
			
	if parent.is_on_floor():
		return landed_state
	return null
	
func exit():
	input_dir = Vector2(0.0, 0.0)
	midi_direction = Vector2(0.0, 0.0)
