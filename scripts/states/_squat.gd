extends _State

const nameState = "Squat"
var debugString = "Debug - " + nameState + ": "

# Stickmap Regions
## JumpSquatSuper
var regionJumpSquatSuper = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))

## Squat ( Crouch )
var regionSquatWait = Region.new(Vector2(-0.7750,-1.000),Vector2(0.7750,-0.6250))


var input_vector
var accelApplied = 0

var scaleDirFacing

var ctr_squat

#func enter() -> void:
#	super()

@export
var stateJumpSquatSuper : _State

@export
var stateSquatWait : _State

@export
var stateSquatRv : _State

var mapRegionLeft = [
	
	[ regionJumpSquatSuper, stateJumpSquatSuper ],
	[ regionSquatWait, stateSquatWait ]
]

func enter():
	super()
	
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1

	parent.charge_jumpSuper = 0
	ctr_squat = 0

	return null

func process_physics( delta : float ) -> _State:

	input_vector = input.get_region_left_stick()

#	print(debugString,input_vector)
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
#	print(debugString,"Squat Counter: ",ctr_squat)
	
	if not parent.is_facing_right:
		input_vector.x *= -1

	ctr_squat += 1
	parent.charge_jumpSuper +=1

	if ctr_squat <= parent.FRAME_SQUAT:
#		print(debugString,"Check: 1")
		
		if regionJumpSquatSuper.has_point(input_vector):
#			print(debugString,"Check: 1.A")
			return stateJumpSquatSuper
			
		else:
#			print(debugString,"Check: 1.B")
			pass
	
	else:
#		print(debugString,"Check: 2")
		if regionJumpSquatSuper.has_point(input_vector):
#			print(debugString,"Check: 2.A")
			return stateJumpSquatSuper
			
		elif regionSquatWait.has_point(input_vector):
#			print(debugString,"Check: 2.B")
			return stateSquatWait
			
		else:
#			print(debugString,"Check: 2.C")
			return stateSquatRv

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
