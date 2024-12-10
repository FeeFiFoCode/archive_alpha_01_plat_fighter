extends _State

const nameState = "Run"
var debugString = "Debug - " + nameState + ": "

# Regions
## Skid in Run
var regionSkid = Region.new(Vector2(-0.3625,-0.6500), Vector2(0.6125,0.5500) )

## TurnRun in Run
var regionTurnRun = Region.new(Vector2(-1.000,-0.6500), Vector2(-0.3750,0.5500))

## Run in Run
var regionRun = Region.new(Vector2(0.6250,-0.6500), Vector2(1.000,0.5500))

## JumpSquat in Run
var regionJumpSquat = Region.new(Vector2(-1.000,0.5625),Vector2(1.000,1.000))

## Squat in Run
var regionSquat = Region.new(Vector2(-1.000,-1.000),Vector2(1.000,-0.6625))

# 
var input_vector
var accelApplied = 0

var scaleDirFacing

var speedCurrent
var speedTarget
var stickX

var accelRun

# 
@export
var stateSkid : _State

@export
var stateTurnRun : _State

@export
var stateRun : _State

@export
var stateJumpSquat : _State

@export
var stateSquat :_State

var mapRegionLeft = [
	[ regionSkid, stateSkid ],

	[ regionRun, stateRun],
	
	[ regionTurnRun, stateTurnRun ],
	
	[ regionJumpSquat, stateJumpSquat ],
	[ regionSquat, stateSquat ]
]

func enter():
	super()
	
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1

	speedCurrent = abs( parent.velocity.x )
#	if parent.previous_state == stateDash:
#		scaleReDash = true
#	else:
#		scaleReDash = false
	
	return null

func process_physics( delta : float ) -> _State:
	input_vector = input.get_region_left_stick()
#	input_vector = Vector2(0.9,0.2)

#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
	
	if not parent.is_facing_right:
		input_vector.x *= -1
		
	if regionJumpSquat.has_point(input_vector):
		return stateJumpSquat
	
	
	if regionSkid.has_point(input_vector):
#		print(debugString,"Go to Skid")
		return stateSkid

	elif regionRun.has_point(input_vector):
#		print(debugString,"Stay in Run")
		pass
		
	elif regionJumpSquat.has_point(input_vector):
#		print("Debug - _walkSlow.gd : Go to JumpSquat")
		return stateJumpSquat
		
	elif regionTurnRun.has_point(input_vector):
#		print(debugString,"Go to Turn Run")
		return stateTurnRun

	elif regionSquat.has_point(input_vector):
#		print(debugString,"Go to Squat")
		return stateSquat
	
	else:
		print(debugString,"Unhandled Region")
		print(debugString,input_vector)
		pass

	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1
	
	
	speedCurrent = abs( parent.velocity.x )
	stickX = abs( input_vector.x )
	

	speedTarget = parent.RUN_SPEED_MAX * stickX
#	print(debugString,"Parent Dash Speed Max is: ",parent.DASH_SPEED_MAX)
#		print(debugString,"speedTarget is: ",speedTarget)
	
	if speedCurrent == 0:
#		print(debugString,"Debug Check Right.1A: ",speedCurrent,speedTarget)
#		accelDashStanding = parent.ACCEL_DASH_BASE + ( stickX * parent.ACCEL_DASH_SCALE )
		accelApplied = parent.RUN_SPEED_INIT
		
	elif speedCurrent > 0:
		if speedCurrent > speedTarget:
#			print(debugString,"Debug Check Right.2A")
			accelApplied = parent.TRACTION
			
		elif speedCurrent < speedTarget:
#			print(debugString,"Debug Check Right.2B")
			accelRun = parent.ACCEL_RUN_BASE + ( stickX * parent.ACCEL_RUN_SCALE )
#			accelDash = accelDashStanding * ( 1 - speedCurrent/speedTarget)
			accelApplied = accelRun

		else:
#			print(debugString,"Debug Check Right.2C")
			accelApplied = 0

	else:
#		print(debugString,"Debug Check Right.3A")
		accelRun = parent.ACCEL_RUN_BASE + ( stickX * parent.ACCEL_RUN_SCALE )
		accelApplied = accelRun

	accelApplied *= scaleDirFacing
	
	# Stop Acceleration from Overshooting
	if sign(parent.velocity.x) == -1*sign(parent.velocity.x + accelApplied ):
		parent.velocity.x = 0
	else:
		parent.velocity.x += accelApplied

	parent.move_and_slide()
	
	return null
