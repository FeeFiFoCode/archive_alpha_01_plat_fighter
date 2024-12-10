extends _State

const nameState = "Jump Squat"
var debugString = "Debug - " + nameState + ": "

# Regions
var regionJumpSquat = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))


# 
var input_vector
var accelApplied = 0

var ctr_jumpSquat
var flag_SH

#func enter() -> void:
#	super()

#
#@export
##var stateIdle : _State

#var stateFall : _State

#@export
#var stateWalkSlow : _State
@export
var stateFall : _State

@export
var stateFullHop : _State

@export
var stateShortHop : _State

var mapRegionLeft = [
]

func enter():
	super()
	
	ctr_jumpSquat = 0
	flag_SH = false

func process_physics( delta : float ) -> _State:
	if not parent.is_on_floor():
#		print(debugString,"Parent on floor: ",parent.is_on_floor())
		return stateFall
		
	ctr_jumpSquat += 1

	input_vector = input.get_region_left_stick()

#	print(debugString,input_vector)
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
	
	if not parent.is_facing_right:
		input_vector.x *= -1
		
	
	if not regionJumpSquat.has_point(input_vector):
		flag_SH = true
		
	else:
		pass
	
	if ctr_jumpSquat >= parent.FRAME_JUMP:
		if flag_SH:
			return stateShortHop
		else:
			return stateFullHop
			
	else:
#		print(debugString,"JS Ctr: ",ctr_jumpSquat)
		pass





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
