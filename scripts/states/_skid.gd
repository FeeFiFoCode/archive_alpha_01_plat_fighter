extends _State

const nameState = "Skid"
var debugString = "Debug - " + nameState + ": "

# Regions
## Skid in Skid
var regionSkid = Region.new(Vector2(-0.3625,-0.6500), Vector2(1.000,0.5500) )

## TurnRun in Skid
var regionTurnRun = Region.new(Vector2(-1.000,-0.6500), Vector2(-0.3750,0.5500))

## JumpSquat in Run
var regionJumpSquat = Region.new(Vector2(-1.000,0.5625),Vector2(1.000,1.000))

## Squat in Run
var regionSquat = Region.new(Vector2(-1.000,-1.000),Vector2(1.000,-0.6625))

## Opens up once Traction is 0 ?
## Give skid a primary, secondary, and buffer timing.
## If  primary
### then can immediately go into turnRun

## If secondary
### then cannot enter turnRun
### but can buffer into tiltTurn... maybe ignore this buffer for now?

## If buffer window
### then can go into either slowWalk or Dash or Dashback

## Otherwise
### On "deadzone" just go into Idle
var regionIdle = Region.new(Vector2(-0.2750,-0.6500), Vector2(0.2750,0.6500) )
var regionWalkSlow = Region.new(Vector2(0.2875,-0.6500), Vector2(0.7875,0.6500))
var regionDash = Region.new(Vector2(0.8000,-0.6500),Vector2(1.000,0.6500))
var regionDashBack = Region.new(Vector2(-1.000,-0.6500),Vector2(-0.8000,0.6500))
var regionTiltTurn = Region.new(Vector2(-0.7875,-0.6500), Vector2(-0.2875,0.6500))

# 
var input_vector
var accelApplied = 0


#func enter() -> void:
#	super()

#
@export
var stateSkid : _State

@export
var stateTurnRun : _State

@export
var stateJumpSquat : _State

@export
var stateSquat : _State

@export
var stateIdle : _State

@export
var stateTiltTurn :_State

@export
var stateDash : _State

@export
var stateDashBack :_State

@export
var stateWalkSlow : _State

# 
var mapRegionLeft = [
	[ regionSkid, stateSkid ],
	
	[ regionTurnRun, stateTurnRun ],
	
	[ regionJumpSquat, stateJumpSquat ],
	[ regionSquat, stateSquat ],
	
	[ regionIdle, stateIdle ],
	[ regionTiltTurn, stateTiltTurn ],
	[ regionDash, stateDash ],
	[ regionDashBack, stateDashBack ],
	[ regionWalkSlow, stateWalkSlow ]
]

func process_physics( delta : float ) -> _State:

	input_vector = input.get_region_left_stick()

#	print(debugString,input_vector)
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
	
	if not parent.is_facing_right:
		input_vector.x *= -1
	
	if parent.velocity.x == 0:
		if regionIdle.has_point(input_vector):
			return stateIdle
		elif regionWalkSlow.has_point(input_vector):
			return stateWalkSlow
		elif regionDash.has_point(input_vector):
			return stateDash
		elif regionDashBack.has_point(input_vector):
			return stateDashBack
		elif regionTiltTurn.has_point(input_vector):
			return stateTiltTurn
#			print(debugString,"Stay in Skid")
		else:
			print(debugString,"Unhandled Behavior")
			print(debugString,"Velocity Is: ",parent.velocity.x)
			print(debugString,"Facing Right is ",parent.is_facing_right)
			print(debugString,"Un-modified Input Vector: ",input_vector)
	
	else:
		if regionSkid.has_point(input_vector):
			pass

		elif regionTurnRun.has_point(input_vector):
#			print(debugString,"Go to TurnRun")
			return stateTurnRun

		elif regionJumpSquat.has_point(input_vector):
	#		print(debugString,"Go to JumpSquat")
			return stateJumpSquat

		elif regionSquat.has_point(input_vector):
	#		print(debugString,"Go to Squat")
			return stateSquat

		else:
			print(debugString,"None of the above")
			print(debugString,"Velocity Is: ",parent.velocity.x)
			print(debugString,"Facing Right is ",parent.is_facing_right)
			print(debugString,"Modified Input Vector: ",input_vector)

	# What Stats should be used for this?
	## May setup Skid stats, but just set them to walk values for now.
	if parent.velocity.x > parent.SKID_SPEED_MAX:
		accelApplied = 2*parent.TRACTION
	
	elif parent.velocity.x > 0:
		accelApplied = parent.TRACTION
	
	elif parent.velocity.x < -1*parent.SKID_SPEED_MAX:
		accelApplied = -2 * parent.TRACTION
		
	elif parent.velocity.x < 0:
		accelApplied = -1 * parent.TRACTION
	else:
		pass
	
	# Check if accelerating will cross 0.
	## If it does not, then just acceelerate as normal.
	## If it does, then just set velocity to 0.
	if sign(parent.velocity.x) == sign(parent.velocity.x + accelApplied ):
		parent.velocity.x += accelApplied
	else:
		parent.velocity.x = 0

	parent.move_and_slide()

	return null
