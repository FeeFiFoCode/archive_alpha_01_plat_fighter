extends _State

const nameState = "SquatWait"
var debugString = "Debug - " + nameState + ": "

# Stickmap Regions
## Walk
var regionWalkSlow = Region.new(Vector2(0.2875,-0.6500), Vector2(0.6125,0.6500))

## Dashes
## Adapted for Crouch
var regionDash = Region.new(Vector2(0.8000,-0.6000),Vector2(1.000,0.5500))
var regionDashBack = Region.new(Vector2(-1.000,-0.6000),Vector2(-0.8000,0.5500))

## JumpSquats ( SH, FH 
var regionJumpSquat = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))

## Squat ( Crouch )
var regionSquatWait = Region.new(Vector2(-0.7750,-1.000),Vector2(0.7750,-0.6250))

var input_vector
var accelApplied = 0

var scaleDirFacing

#func enter() -> void:
#	super()

@export
var stateJumpSquat : _State

@export
var stateWalkSlow : _State

@export
var stateDash : _State

@export
var stateDashBack : _State

@export
var stateSquatWait : _State

@export
var stateSquatRv : _State

var mapRegionLeft = [
	[ regionWalkSlow, stateWalkSlow ],
	
	[ regionDash , stateDash ],
	[ regionDashBack, stateDashBack ],
	
	[ regionJumpSquat, stateJumpSquat ],
	[ regionSquatWait, stateSquatWait ]
]

func enter():
	super()
	
	if parent.is_facing_right:
		scaleDirFacing = 1
	else:
		scaleDirFacing = -1

	return null

func process_physics( delta : float ) -> _State:
	
	input_vector = input.get_region_left_stick()


	if regionJumpSquat.has_point(input_vector):
		return stateJumpSquat
	
	elif regionWalkSlow.has_point(input_vector):
		return stateWalkSlow
		
	elif regionDash.has_point(input_vector):
		return stateDash
		
	elif regionDashBack.has_point(input_vector):
		return stateDashBack
		
	elif regionSquatWait.has_point(input_vector):
#		print(debugString,"Stay in Squat Wait")
		pass
	
	else:
#		print(debugString,"Go to Squat Rv")
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
