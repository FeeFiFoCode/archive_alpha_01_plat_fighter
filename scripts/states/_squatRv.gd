extends _State

const nameState = "SquatRv"
var debugString = "Debug - " + nameState + ": "

# Stickmap Regions
## Enter Idle, Adjusted for Crouch
var regionIdle = Region.new(Vector2(-0.2750,-0.6500), Vector2(0.2750,0.6750) )

## Walk
### Adjusted for Crouch
var regionWalkSlow = Region.new(Vector2(0.2875,-0.6500), Vector2(0.8500,0.6500))

## Tilt Turn
var regionTiltTurn = Region.new(Vector2(-0.7875,-0.6500), Vector2(-0.2875,0.6500))

## JumpSquats ( SH, FH )
var regionJumpSquat = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))

# 
var input_vector
var accelApplied = 0

var scaleDirFacing
var ctr_squat_rv

#func enter() -> void:
#	super()

@export
var stateIdle : _State

@export
var stateWalkSlow : _State

@export
var stateTiltTurn : _State

@export
var stateJumpSquat : _State

var mapRegionLeft = [
	[ regionIdle , stateIdle ],
	
	[ regionWalkSlow, stateWalkSlow ],
	[ regionTiltTurn, stateTiltTurn ],
	
	[ regionJumpSquat, stateJumpSquat ]
]

func enter():
	super()
	
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1

	ctr_squat_rv = 0
	
	return null

func process_physics( delta : float ) -> _State:

	input_vector = input.get_region_left_stick()

#	print(debugString,input_vector)
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
#	print(debugString,"Squat Counter: ",ctr_squat_rv)
	
	if not parent.is_facing_right:
		input_vector.x *= -1

	ctr_squat_rv += 1

	# Notice the pattern structure has changed a bit relative to other
	## countinng states.
	## here it's if the frame is < than the ctr
	## in other scripts it's if the cntr <= frame

	if regionJumpSquat.has_point(input_vector):
#			print(debugString,"Check: 1.A")
		return stateJumpSquat
	
	elif regionTiltTurn.has_point(input_vector):
		return stateTiltTurn
		
	elif regionWalkSlow.has_point(input_vector):
		return stateWalkSlow
		
	else:
##		print(debugString,"Stay in SquatRv")
#		print(debugString,"Frame Counter: ",ctr_squat_rv)
#		print(debugString,"Velocity Is: ",parent.velocity.x)
#		print(debugString,"Facing Right is ",parent.is_facing_right)
#		print(debugString,"Un-modified Input Vector: ",input_vector)
		pass
	
	if parent.FRAME_SQUAT_RV <  ctr_squat_rv:
		return stateIdle


#	print(debugString,"Check: 3")
	# Movement Logic ( one can still slide into squat )
	if parent.velocity.x > parent.WALK_SPEED_MAX:
		accelApplied = 2*parent.TRACTION
	
	elif parent.velocity.x > 0:
		accelApplied = parent.TRACTION
	
	elif parent.velocity.x < -1*parent.WALK_SPEED_MAX:
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
