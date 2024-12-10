extends _State

const nameState = "WalkFast"
var debugString = "Debug: " + nameState + " "

# Regions
var regionJumpSquat = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))

var regionDeadzone = Region.new(Vector2(-0.2750,-0.6500), Vector2(0.2750,0.6500) )

var regionWalkSlow = Region.new(Vector2(0.2875,-0.6500), Vector2(0.4000,0.6500))
var regionWalkMid = Region.new(Vector2(0.4125,-0.6500), Vector2(0.8000,0.6500))
var regionWalkFast = Region.new(Vector2(0.8125,-0.6500), Vector2(1.000,0.6500))

var regionTiltTurn = Region.new(Vector2(-0.7875,-0.6500), Vector2(-0.2875,0.6500))

var regionDash = Region.new(Vector2(0.8000,-0.6500),Vector2(1.000,0.6500))
var regionDashBack = Region.new(Vector2(-1.000,-0.6500),Vector2(-0.8000,0.6500))

var regionSquat = Region.new(Vector2(-0.7875,-1.000),Vector2(0.7875,-0.6625))

#
var input_vector

var speedTarget
var speedCurrent
var accelWalkStanding
var accelWalk
var accelApplied

var stickX
var direction

var scaleDirFacing

var ctr_Walk



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

@export
var stateJumpSquat : _State

@export
var stateTiltTurn : _State

@export
var stateDash : _State

@export
var stateDashBack : _State

@export
var stateSquat : _State


var mapRegionLeft = [
	[ regionDeadzone, stateIdle ],
	[ regionWalkSlow, stateWalkSlow ],
	[ regionWalkMid , stateWalkMid ],
	[ regionWalkFast, stateWalkFast ],
	[ regionJumpSquat, stateJumpSquat ],
	[ regionTiltTurn, stateTiltTurn ],
	[ regionDash, stateDash ],
	[ regionDashBack, stateDashBack],
	[ regionSquat, stateSquat ]
]

func enter():
	super()
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1
		
	ctr_Walk = 0
	
	return null


func process_physics( delta : float ) -> _State:
	ctr_Walk += 1
	input_vector = input.get_region_left_stick()

##	print(debugString,input_vector)
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
	
	if not parent.is_facing_right:
		input_vector.x *= -1
	
	if ctr_Walk < parent.FRAME_PRE_DASH_STEP:
		if regionDash.has_point(input_vector):
			return stateDash
	
	if regionDeadzone.has_point(input_vector):
		return stateIdle
		
	elif regionWalkSlow.has_point(input_vector):
		return stateWalkSlow

	elif regionWalkMid.has_point(input_vector):
		return stateWalkMid
		
	elif regionWalkFast.has_point(input_vector):
		pass
		
	elif regionJumpSquat.has_point(input_vector):
		return stateJumpSquat
		
	elif regionTiltTurn.has_point(input_vector):
#		print(debugString,"Go to tiltTurn")
		return stateTiltTurn
		
	elif regionDashBack.has_point(input_vector):
#		print(debugString,"Go to Dash Back")
		return stateDashBack
		
	elif regionSquat.has_point(input_vector):
		return stateSquat
		
	else:
		print(debugString,"None of the above")
		print(debugString,"Velocity Is: ",parent.velocity.x)
		print(debugString,"Facing Right is ",parent.is_facing_right)
		print(debugString,"Un-modified Input Vector: ",input_vector)
		
		
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1
		
#	if parent.is_facing_right:

#		speedCurrent = abs( parent.velocity.x )*scaleDirFacing
#		stickX = abs( Input.get_joy_axis(0,JOY_AXIS_LEFT_X) )*scaleDirFacing
	speedCurrent = abs( parent.velocity.x )
	stickX = abs( input_vector.x )
	
#		if Input.get_joy_axis(0,JOY_AXIS_LEFT_X) < 0:
#			direction = -1
#		else:
#			direction = 1
	
	speedTarget = parent.WALK_SPEED_MAX * stickX
#		print("Position:",parent.transform)
#		print("Velocity X:",parent.velocity.x)
	
	if speedCurrent == 0:
#		print(debugString,"Debug Check Right.1A")
		accelWalkStanding = parent.ACCEL_WALK_BASE + ( stickX * parent.ACCEL_WALK_SCALE )
		accelApplied = accelWalkStanding
		
	elif speedCurrent > 0:
		if speedCurrent > speedTarget:
#			print(debugString,"Debug Check Right.2A")
#				accelApplied = parent.TRACTION * direction
			accelApplied = parent.TRACTION
			
		elif speedCurrent < speedTarget:
#			print(debugString,"Debug Check Right.2B")
			accelWalkStanding = parent.ACCEL_WALK_BASE + ( stickX * parent.ACCEL_WALK_SCALE )
			accelWalk = 0.5 * accelWalkStanding * ( 1 - speedCurrent/speedTarget)
			accelApplied = accelWalk

		else:
#			print(debugString,"Debug Check Right.2C")
			accelApplied = 0

	else:
#		print(debugString,"Debug Check Right.3A")
		accelWalkStanding = parent.ACCEL_WALK_BASE + ( stickX * parent.ACCEL_WALK_SCALE )
		accelApplied = accelWalkStanding
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
	


#	print("DeadzoneLeft: ",deadzoneLeft)
#	return null
	
	return null
#
#func process_frame(delta : float ) -> _State:

	
#Vector2 get_vector ( StringName negative_x, StringName positive_x, StringName negative_y, StringName positive_y, float deadzone=-1.0 )


#func exit():
#	input_dir = Vector2(0.0, 0.0)
#	midi_direction = Vector2(0.0, 0.0)
