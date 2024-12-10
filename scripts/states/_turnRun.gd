extends _State

const nameState = "Turn Run"
var debugString = "Debug - " + nameState + ": "

# Regions
## JumpSquat in Run
var regionJumpSquat = Region.new(Vector2(-1.000,0.5625),Vector2(1.000,1.000))

## Squat in Run
var regionSquat = Region.new(Vector2(-1.000,-1.000),Vector2(1.000,-0.6625))

## Run in Run
var regionRun = Region.new(Vector2(0.6250,-0.6500), Vector2(1.000,0.6500))

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
var regionDashBack = Region.new(Vector2(-1.000,-0.6500),Vector2(-0.8000,0.6500))
var regionTiltTurn = Region.new(Vector2(-0.7875,-0.6500), Vector2(-0.2875,0.6500))

# 
var input_vector
var accelApplied = 0


#func enter() -> void:
#	super()


@export
var stateJumpSquat : _State

@export
var stateSquat : _State

@export
var stateIdle : _State

@export
var stateTiltTurn :_State

@export
var stateDashBack :_State

@export
var stateRun : _State

@export
var stateWalkSlow : _State

# 
var mapRegionLeft = [	
	[ regionJumpSquat, stateJumpSquat ],
	[ regionSquat, stateSquat ],
	
	[ regionIdle, stateIdle ],
	[ regionTiltTurn, stateTiltTurn ],
	[ regionDashBack, stateDashBack ],
	[ regionRun, stateRun ],
	[ regionWalkSlow, stateWalkSlow ]
]

func enter():
	super()
	# logically flip the way parent is facing
	# Questionable Rotation Approach...
	if parent.is_facing_right:
		# Questionable Approach
		parent.body.rotate_object_local(Vector3(0, 1, 0), parent.AMT_ROTATION)
		parent.is_facing_right = not parent.is_facing_right
	else:
		parent.body.rotate_object_local(Vector3(0, 1, 0), -1*parent.AMT_ROTATION)
		parent.is_facing_right = not parent.is_facing_right
	
	pass

func process_physics( delta : float ) -> _State:

	input_vector = input.get_region_left_stick()

#	print(debugString,input_vector)
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
	
	if not parent.is_facing_right:
		input_vector.x *= -1
	
	if parent.velocity.x == 0:
		if regionJumpSquat.has_point(input_vector):
	#		print(debugString,"Go to JumpSquat")
			return stateJumpSquat

		elif regionSquat.has_point(input_vector):
	#		print(debugString,"Go to Squat")
			return stateSquat
			
		elif regionIdle.has_point(input_vector):
			return stateIdle
		elif regionRun.has_point(input_vector):
			return stateRun
		elif regionWalkSlow.has_point(input_vector):
			return stateWalkSlow
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

		if regionJumpSquat.has_point(input_vector):
	#		print(debugString,"Go to JumpSquat")
			return stateJumpSquat

		elif regionSquat.has_point(input_vector):
	#		print(debugString,"Go to Squat")
			return stateSquat

		else:
			pass
#			print(debugString,"None of the above")
#			print(debugString,"Velocity Is: ",parent.velocity.x)
#			print(debugString,"Facing Right is ",parent.is_facing_right)
#			print(debugString,"Modified Input Vector: ",input_vector)

	# What Stats should be used for this?
	## May setup Skid stats, but just set them to walk values for now.
	if parent.velocity.x > parent.SKID_SPEED_MAX:
		# NOTE!!!! originally, this was 2* parent.TRACTION
		## 8 is interesting... trying for 4
		accelApplied = 4*parent.TRACTION
	
	elif parent.velocity.x > 0:
		accelApplied = parent.TRACTION
	
	elif parent.velocity.x < -1*parent.SKID_SPEED_MAX:
		# NOTE!!!! originally, this was 2* parent.TRACTION
		accelApplied = -4 * parent.TRACTION
		
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
