extends _State

const nameState = "Dash"
var debugString = "Debug: " + nameState + " "

# Stickmap Regions
## Enter Idle
var regionDeadzone = Region.new(Vector2(-0.2750,-0.6500), Vector2(0.2750,0.6500) )

## Walk
var regionWalkSlow = Region.new(Vector2(0.2875,-0.6500), Vector2(0.6125,0.6500))

## JumpSquats ( SH, FH )
var regionJumpSquat = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))

## Tilt Turn
var regionTiltTurn = Region.new(Vector2(-0.7875,-0.6500), Vector2(-0.2875,0.6500))

## Dashes & Run
var regionDash = Region.new(Vector2(0.8000,-0.6500),Vector2(1.000,0.6500))
var regionDashBack = Region.new(Vector2(-1.000,-0.6500),Vector2(-0.8000,0.6500))

var regionRun = Region.new(Vector2(0.6250,-0.6500), Vector2(1.000,0.6500))

## Squat ( Crouch )
var regionSquat = Region.new(Vector2(-0.7875,-1.000),Vector2(0.7875,-0.6625))

#
var input_vector

var speedTarget
var speedCurrent
var accelDashStanding
var accelDash = 0
var accelApplied

var stickX
var direction

# Scalers & Multipliers
var scaleDirFacing
var scaleReDash

# Counters
var ctr_dash = 0

# States
## Idle
@export
var stateIdle : _State

## Walks
@export
var stateWalkSlow : _State
@export
var stateWalkMid : _State
@export
var stateWalkFast : _State

## JumpSquat Squat ( SH, FH )
@export
var stateJumpSquat : _State

var stateShortHop : _State
var stateFullHop : _State

## Tilt Turn
@export
var stateTiltTurn : _State

## Dash & Run
@export
var stateDash : _State
 
@export
var stateDashBack : _State

@export
var stateRun : _State

## Crouch ( Squat )
@export
var stateSquat : _State

## Temp / Holding
var stateFall : _State
var stateTurnDashJumpSquat : _State

# Stick Map & State
var mapRegionLeft = [
	[ regionDeadzone, stateIdle ],
	[ regionWalkSlow, stateWalkSlow ],
	[ regionJumpSquat, stateJumpSquat ],
	[ regionTiltTurn, stateTiltTurn ],
	[ regionDash, stateDash ],
	[ regionDashBack, stateDashBack ],
	[ regionSquat, stateSquat ],
	[ regionRun, stateRun ]
]

func enter():
	super()
#	speedCurrent = abs( parent.velocity.x )
	
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1

#	if parent.previous_state == stateDash:
#		scaleReDash = true
#	else:
#		scaleReDash = false

	ctr_dash = 0
	
	return null

func process_physics( delta : float ) -> _State:
#	print(debugString,"Counter: ",ctr_dash)
	ctr_dash += 1
	input_vector = input.get_region_left_stick()
#
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
#
	if not parent.is_facing_right:
		input_vector.x *= -1
		
	if regionJumpSquat.has_point(input_vector):
		return stateJumpSquat
		
	if ctr_dash > parent.FRAME_DASH_STEP:
#		print(debugString,"ctr_dash value: ",ctr_dash)
		if regionDashBack.has_point(input_vector):
			print(debugString,"Should go to Dashback: ",ctr_dash)
#			print(debugString,"Go to Dash Back")
#			print(debugString,"Testing - Go to Dash Back")
			return stateDashBack
	
	if ctr_dash > parent.FRAME_DASH_PRIME:
#		print(debugString,"ctr_dash value: ",ctr_dash)
		
		if regionRun.has_point(input_vector):
#			print(debugString,"Go to Run")
			return stateRun
			
		elif regionJumpSquat.has_point(input_vector):
	#		print("Debug - _walkSlow.gd : Go to JumpSquatSquat")
			pass
			
		elif regionTiltTurn.has_point(input_vector):
#			print(debugString,"Go to tilt Turn")
			return stateTiltTurn
	
	if ctr_dash > parent.FRAME_DASH_SEC:
		if regionWalkSlow.has_point(input_vector):
#			print(debugString,"Go to walkSlow")
			return stateWalkSlow

#		elif regionWalkMid.has_point(input_vector):
#			print("Debug - _walkSlow.gd : Go to walkMid")
#			return stateWalkMid
#
#		elif regionWalkFast.has_point(input_vector):
#			print("Debug - _walkSlow.gd : Go to walkFast")
#			return stateWalkFast
			
	if ctr_dash > parent.FRAME_DASH_COOL:
		if regionDeadzone.has_point(input_vector):
#			print(debugString,"Go to Idle")
	#		print("Debug - _walkSlow.gd : Go to Idle")
			return stateIdle
		
		elif regionSquat.has_point(input_vector):
#			print(debugString,"Go to Squat")
			return stateSquat
		
		else:
			print(debugString,"Placeholder")
			print(debugString,"ctr dash: ",ctr_dash)
			print(debugString,input_vector)
			pass
#

	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1
	
	if ctr_dash == 1:
#		parent.velocity.x = parent.DASH_SPEED_INIT*scaleDirFacing
		pass
	
	else:

		speedCurrent = abs( parent.velocity.x )
		stickX = abs( input_vector.x )
		

		speedTarget = parent.DASH_SPEED_MAX * stickX
	#	print(debugString,"Parent Dash Speed Max is: ",parent.DASH_SPEED_MAX)
#		print(debugString,"speedTarget is: ",speedTarget)
		
		if speedCurrent == 0:
#			print(debugString,"Debug Check Right.1A: ",speedCurrent,speedTarget)
	#		accelDashStanding = parent.ACCEL_DASH_BASE + ( stickX * parent.ACCEL_DASH_SCALE )
			accelApplied = parent.DASH_SPEED_INIT
			
		elif speedCurrent > 0:
			if speedCurrent > speedTarget:
#				print(debugString,"Debug Check Right.2A")
				accelApplied = parent.TRACTION
				
			elif speedCurrent < speedTarget:
#				print(debugString,"Debug Check Right.2B")
				accelDash = parent.ACCEL_DASH_BASE + ( stickX * parent.ACCEL_DASH_SCALE )
	#			accelDash = accelDashStanding * ( 1 - speedCurrent/speedTarget)
				accelApplied = accelDash

			else:
#				print(debugString,"Debug Check Right.2C")
				accelApplied = 0

		else:
#			print(debugString,"Debug Check Right.3A")
			accelDash = parent.ACCEL_DASH_BASE + ( stickX * parent.ACCEL_DASH_SCALE )
			accelApplied = accelDash
	
		accelApplied *= scaleDirFacing
		
		# Stop Acceleration from Overshooting
		if sign(parent.velocity.x) == -1*sign(parent.velocity.x + accelApplied ):
			parent.velocity.x = 0
		else:
			parent.velocity.x += accelApplied
	
	parent.move_and_slide()
	
	return null
