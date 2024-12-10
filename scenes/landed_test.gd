extends State

@export
var fall_state : State
@export
var idle_state : State
#@export
#var move_state : State

const LANDING_LAG = 4
#const LANDING_LAG_HEAVY = 15

var input_dir
var direction
var lag_landing

func enter() -> void:
	super()	
	lag_landing = LANDING_LAG
	ctr_wave_air = CTR_WAVE_AIR
	ctr_jump = CTR_JUMP_MAX
#	print("DEBUG - From Landing - Jumps Remaining:",ctr_jump)
#	print(parent.velocity.y)

func process_physics( delta : float ) -> State:
#	print(parent.velocity.x)
#	print(parent.velocity.y)
#	print("Debug: Is Parent on Floor: ",parent.is_on_floor())
#	parent.velocity.y += gravity * delta
#	parent.move_and_slide()
#	print(parent.velocity.y)
	lag_landing -= 1

	if not parent.is_on_floor():
		return fall_state
	elif lag_landing <= 0:
			return idle_state
	else:
		print("Debug - landed_test.gd - Velocity is: ",parent.velocity)
	#	parent.velocity.move_toward(Vector3(0,0,0), traction)
		parent.velocity.x = move_toward(parent.velocity.x, 0, traction)
		parent.velocity.y = move_toward(parent.velocity.y, 0, move_speed)
		parent.velocity.z = move_toward(parent.velocity.z, 0, move_speed)
	
	parent.move_and_slide()
	
	return null
