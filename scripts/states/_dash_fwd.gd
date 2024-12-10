extends _State

const nameState = "WalkSlow"
var debugString = "Debug: " + nameState + " "

var regionIdle = Region.new(Vector2(-0.2750,-0.6875), Vector2(0.2750,0.6500) )

var regionWalkSlow = Region.new(Vector2(0.2875,-0.6875), Vector2(0.4000,0.6500))
var regionWalkMid = Region.new(Vector2(0.4125,-0.6875), Vector2(0.8000,0.6500))
var regionWalkFast = Region.new(Vector2(0.8125,-0.6875), Vector2(1.000,0.6500))

var regionJump = Region.new(Vector2(-0.7375,0.6625),Vector2(0.7375,1.000))
var regionTiltTurn = Region.new(Vector2(-0.7875,-0.6875), Vector2(-0.2875,0.6500))

var regionTurnDash = Region.new(Vector2(-1.000,-0.6000),Vector2(-0.8000,0.5500))
var regionTurnDashJump = Region.new(Vector2(-0.8250,0.5626),Vector2(-0.8000,0.6000))

var regionSquat = Region.new(Vector2(-0.7875,-0.6250),Vector2(0.7875,-0.6250))
var input_vector

var speedTarget
var speedCurrent
var accelDashStanding
var accelDash
var accelApplied

var stickX
var direction

var scaleDirFacing



#
@export
var stateIdle : _State

var stateFall : _State

@export
var stateWalkSlow : _State
@export
var stateWalkMid : _State
@export
var stateWalkFast : _State

var stateJump : _State

@export
var stateTiltTurn : _State

@export
var stateSquat : _State

var stateTurnDash : _State
var stateTurnDashJump : _State


		
#@export
#var jump_state : _State
#@export
#var move_state : _State
#@export
#var waveGround_state : _State

var mapRegionLeft = [
	[ regionIdle, stateIdle ],
	[ regionWalkSlow, stateWalkSlow ],
	[ regionWalkMid , stateWalkMid ],
	[ regionWalkFast, stateWalkFast ],
	[ regionJump, stateJump ],
	[ regionTiltTurn, stateTiltTurn ],
	[ regionTurnDash, stateTurnDash ],
	[ regionTurnDashJump, stateTurnDashJump ],
	[ regionSquat, stateSquat ]
]

func enter():
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1
	
	return null
#
#var input_dir
#var midi_direction = Vector2(0.0, 0.0)
#var direction
#var previous_input
#
#func enter() -> void:
#	super()
##	parent.velocity.x = 0
##	parent.velocity.z = 0
##	print(parent.velocity.y)
#	ctr_wave_air = CTR_WAVE_AIR
#	ctr_jump = CTR_JUMP_MAX
#
#	if move_component.input_buffer.size() > 0:
#		previous_input = move_component.input_buffer[-1]
#		if move_component.is_direction_pressed(previous_input):
#			midi_direction = move_component.midi_direction
#
#func process_input(event : InputEvent) -> _State:
##	print("Debug: ",event)
#
#	# Jump Logics
#	if event is InputEventMIDI:
#		if move_component.wants_jump(event) and parent.is_on_floor():
#			return jump_state
#
#	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
#		return jump_state
#
#	# Wave Logics
#	if Input.is_action_just_pressed("wave_burst") and parent.is_on_floor():
#		return waveGround_state
#
#	if event is InputEventMIDI:
#		if move_component.wants_wave(event) and parent.is_on_floor():
#			return waveGround_state
#
#	# Move Logics
#	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
##		input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
##		direction = parent.transform.basis * Vector3(input_dir.x, 0, 0)
#		return move_state
#
#	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
##		input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
##		direction = parent.transform.basis * Vector3(input_dir.x, 0, 0)
#		return move_state
#
#	if event is InputEventMIDI:
#		if move_component.midi_direction(event) and parent.is_on_floor():
#			return move_state
#
#	if event is InputEventMIDI:
#		if move_component.is_direction_pressed(event) and parent.is_on_floor():
#			midi_direction = move_component.midi_direction(event)
#
#	return null
#
#
func process_physics( delta : float ) -> _State:
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1
		
#	if parent.is_facing_right:

#		speedCurrent = abs( parent.velocity.x )*scaleDirFacing
#		stickX = abs( Input.get_joy_axis(0,JOY_AXIS_LEFT_X) )*scaleDirFacing
	speedCurrent = abs( parent.velocity.x )
	stickX = abs( Input.get_joy_axis(0,JOY_AXIS_LEFT_X) )
	
#		if Input.get_joy_axis(0,JOY_AXIS_LEFT_X) < 0:
#			direction = -1
#		else:
#			direction = 1
	
	speedTarget = parent.DASH_SPEED_MAX * stickX
#		print("Position:",parent.transform)
#		print("Velocity X:",parent.velocity.x)
	
	if speedCurrent == 0:
		print("Debug Check Right.1A")
#		accelDashStanding = parent.ACCEL_DASH_BASE + ( stickX * parent.ACCEL_DASH_SCALE )
		accelApplied = accelDash
		
	elif speedCurrent > 0:
		if speedCurrent > speedTarget:
			print("Debug Check Right.2A")
			accelApplied = parent.TRACTION
			
		elif speedCurrent < speedTarget:
			print("Debug Check Right.2B")
			accelDash = parent.ACCEL_DASH_BASE + ( stickX * parent.ACCEL_DASH_SCALE )
#			accelDash = accelDashStanding * ( 1 - speedCurrent/speedTarget)
			accelApplied = accelDash

		else:
			print("Debug Check Right.2C")
			accelApplied = 0

	else:
		print("Debug Check Right.3A")
		accelDash = parent.ACCEL_DASH_BASE + ( stickX * parent.ACCEL_DASH_SCALE )
		accelApplied = accelDash
#
#
#
#
#
#		elif not parent.is_facing_right:
#			if speedCurrent > speedTarget:
#				accelWalkStanding = parent.ACCEL_WALK_BASE + ( stickX * parent.ACCEL_WALK_SCALE )
#				accelWalk = 0.5 * accelWalkStanding * ( 1 - speedCurrent/speedTarget)
#				accelApplied = accelWalk * scaleDirFacing
#
#			elif speedCurrent > speedTarget:
#				accelApplied = parent.TRACTION * scaleDirFacing
#
	#	if not parent.is_facing_right:
	#		accelApplied *= -1
		
	#	print("Debug - _walkSlow, process_physics; accelApplied:",accelApplied)
	accelApplied *= scaleDirFacing
	
	if sign(parent.velocity.x) == -1*sign(parent.velocity.x + accelApplied ):
		parent.velocity.x = 0
	else:
		parent.velocity.x += accelApplied
	
	parent.move_and_slide()
	
	return null
#
func process_frame(delta : float ) -> _State:
#	print ("Debug - Left Stick X:", Input.get_joy_axis(0,JOY_AXIS_LEFT_X) )
#	print ("Debug - Left Stick Y:", Input.get_joy_axis(0,JOY_AXIS_LEFT_Y) )
	input_vector = Vector2( Input.get_joy_axis(0,JOY_AXIS_LEFT_X), Input.get_joy_axis(0,JOY_AXIS_LEFT_Y) )
#	print ("Debug - input vector: ", input_vector)
#	print( deadzoneLeft.position)
#	print (deadzoneLeft.end)
#	print ( deadzoneLeft.size )
#	print ( Input.get_connected_joypads( ) )
#	print ( Input.get_axis("move_left","move_right") )

	if not parent.is_facing_right:
		input_vector.x *= -1

	print(debugString,input_vector)
	print("Facing Right: ",parent.is_facing_right)
	
	if regionIdle.has_point(input_vector):
#		print("Debug - _walkSlow.gd : Go to Idle")
		return stateIdle
		
	elif regionWalkSlow.has_point(input_vector):
#		print("Debug - _walkSlow.gd : Stay in walkSlow")
		pass

	elif regionWalkMid.has_point(input_vector):
#		print("Debug - _walkSlow.gd : Go to walkMid")
		return stateWalkMid
		
	elif regionWalkFast.has_point(input_vector):
#		print("Debug - _walkSlow.gd : Go to walkFast")
		return stateWalkFast
		
	elif regionJump.has_point(input_vector):
#		print("Debug - _walkSlow.gd : Go to Jump")
		pass
		
	elif regionTiltTurn.has_point(input_vector):
#		print("Debug - _walkSlow.gd : Go to Tilt Turn")
		return stateTiltTurn
		
	else:
		print("Debug - _walkSlow.gd : None of the above")

#	print("DeadzoneLeft: ",deadzoneLeft)
	return null
	
#Vector2 get_vector ( StringName negative_x, StringName positive_x, StringName negative_y, StringName positive_y, float deadzone=-1.0 )


#func exit():
#	input_dir = Vector2(0.0, 0.0)
#	midi_direction = Vector2(0.0, 0.0)
