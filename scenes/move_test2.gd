extends State

@export
var fall_state : State
@export
var jump_state : State
@export
var idle_state : State
@export
var waveGround_state : State

var input_dir
var direction

var target_velocity : float
var target_speed : float

var move_stand_accel : float = 0.0

var current_speed : float = 0.0

func enter() -> void:
	super()
	current_speed = parent.velocity.x

func process_input(event : InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
#	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
#		return idle_state
	if Input.is_action_just_pressed("wave_burst") and parent.is_on_floor():
		return waveGround_state
	return null
	
func process_physics( delta : float ) -> State:
	if parent.is_on_floor():
#		# Terminal Velocity
##		velocity.y = maxf(velocity.y - gravity*delta, actual_velocity_terminal )
#		parent.velocity.y -= gravity*delta

		input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		# direction = ( parent.transform.basis * Vector3(input_dir.x, 0, 0) ).normalize()
		direction = parent.transform.basis * Vector3(input_dir.x, 0, 0) * x_sensitivity
		print("Direction: ",direction)
		
		target_speed = abs(direction.x) * move_speed_max
		current_speed = parent.velocity.x
		
		print("Target Speed: ",target_speed)
		print("Current Speed: ",current_speed)
		
		if parent.velocity.x > move_speed_max:
			parent.velocity.x -= 2*traction		
		elif parent.velocity.x >= target_speed:
			if parent.velocity.x - traction <= target_speed:
				parent.velocity.x = target_speed
			else:
				parent.velocity.x -= traction
		elif parent.velocity.x < target_speed:
			move_stand_accel = move_base_accel + direction.x*move_scale_accel
			parent.velocity.x += 0.5*move_stand_accel*(1- parent.velocity.x/target_speed)
#
#
		if direction:
			if direction.x < 0:
				facing_right = false
			else:
				facing_right = true
			print("Debug - Facing Right: ",facing_right)
##			lookdir = atan2(-parent.velocity.x, -parent.velocity.z)
##			parent.rotation.y = lookdir
#
#			parent.velocity.x = direction.x * current_speed
			parent.velocity.x *= direction.x
#		#	velocity.y = -direction.y * actual_speed
#		#	velocity.z = direction.z * actual_speed
#		else:
#			parent.velocity.x = move_toward(parent.velocity.x, 0, traction)
#			parent.velocity.z = move_toward(parent.velocity.z, 0, traction)
#			return idle_state
#
#		parent.velocity.y += gravity * delta	
		parent.move_and_slide()

	if not parent.is_on_floor():
		return fall_state
	return null
