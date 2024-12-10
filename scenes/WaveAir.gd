extends State

@export
var fall_state : State
@export
var landed_state : State
@export
var jump_state : State

const WAVE_LAG_START = 3
const WAVE_LAG_ACTIVE = 5
const WAVE_LAG_END = 7

var wave_lag_start = WAVE_LAG_START
var wave_lag_active = WAVE_LAG_ACTIVE
var wave_lag_end = WAVE_LAG_END

#var is_startup
#var is_active
#var is_end
	
var input_dir
var direction

func enter() -> void:
	super()
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = (parent.transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
	
	wave_lag_start = WAVE_LAG_START
	wave_lag_active = WAVE_LAG_ACTIVE
	wave_lag_end = WAVE_LAG_END
	
#	is_startup = true
#	is_active = false
#	is_end = false

func exit() -> void:
	super()
	ctr_wave_air -= 1 

func process_input(event : InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
#	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
#		return idle_state

	if event is InputEventMIDI:
		if move_component.wants_jump(event) and parent.is_on_floor():
			return jump_state

	return null

func process_physics( delta : float ) -> State:
#	print("Debug: Is Parent on Floor: ",parent.is_on_floor())
#	parent.velocity.y += gravity * delta
#	parent.move_and_slide()
#	print(parent.velocity.y)
#	if is_startup:
#		wave_lag_start -= 1
#	elif is_active:
#		wave_lag_end -= 1
#	else:
#		is_active = false
#		is_end = true
#		if parent.is_on_floor():
#			return idle_state
#		else:
#			return fall_state

#	if parent.is_on_floor():
#		return landed_state
#
#	if wave_lag_start > 0:
#		wave_lag_start -= 1
#
#	elif wave_lag_active > 0:
#		wave_lag_active -= 1
#		# Maybe redundant or can be made to be ? 
#		if direction:
#			parent.velocity.x += direction.x * accel_wave_air
#			parent.velocity.y += -direction.y * accel_wave_air
#
#	elif wave_lag_end > 0:
#		wave_lag_end -= 1
#
#	else:
#		if not parent.is_on_floor():
#			return fall_state
#		else:
#			return landed_state
	
	if wave_lag_start > 0:
		wave_lag_start -= 1
	elif wave_lag_active > 0:
		wave_lag_active -= 1
#		print("Debug: ","Hits 2nd Condition ",wave_lag_active)
		parent.velocity.x = direction.x * waveAir_burst
#		parent.velocity.y = -direction.y * waveAir_burst
	else:
		if parent.is_on_floor():
			return landed_state
		else:
			return fall_state
	
	parent.move_and_slide()
	
	return null
