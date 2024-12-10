extends _State

const nameState = "Turn"
var debugString = "Debug: " + nameState + " "

# Regions
var regionDeadzone = Region.new(Vector2(-0.2750,-0.6500), Vector2(0.2750,0.6500) )
var regionWalkSlow = Region.new(Vector2(0.2875,-0.6500), Vector2(0.7875,0.6500))

var regionTiltTurn = Region.new(Vector2(-1.000,-0.6500), Vector2(-0.2875,0.6500))

var regionDash = Region.new(Vector2(0.8000,-0.6500),Vector2(1.000,0.6500))

var regionJumpSquat = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))
var regionSquat = Region.new(Vector2(-0.7875,-1.000),Vector2(0.7875,-0.6625))
## Planned Regions ?
## var regionMoonWalk
## var regionMoonDash

# 
var input_vector


@export
var stateIdle : _State

#var stateFall : _State
@export
var stateError : _State

@export
var stateWalkSlow : _State

@export
var stateJumpSquat : _State

@export
var stateTiltTurn : _State

@export
var stateSquat : _State

@export
var stateDash : _State

var temp_state : _State

# Frame Counter Variables
var ctr_turn = 1

#@export
#var JumpSquat_state : _State
#@export
#var move_state : _State
#@export
#var waveGround_state : _State

var mapRegionLeft = [
	[ regionDeadzone, stateIdle ],
	[ regionWalkSlow, stateWalkSlow ],
	
	[ regionJumpSquat, stateJumpSquat ],
	
	[ regionTiltTurn, stateTiltTurn ],
	
	[ regionDash , stateDash ],
	
	[ regionSquat, stateSquat ]
]

#
#var input_dir
#var midi_direction = Vector2(0.0, 0.0)
#var direction
#var previous_input
#
func enter():
	super()
	# logically flip the way parent is facing
	# NOTE
	## Interesting glitch if... parent.is_facing_right = not parent.is_facing_right
	### Then again if you do the conditional expression that filps
	### Interesting visibly with the flipping  ( rotating ) approach in here as well
	
	
	# Questionable Rotation Approach...
	if parent.is_facing_right:
		# Questionable Approach
		parent.body.rotate_object_local(Vector3(0, 1, 0), parent.AMT_ROTATION)
		parent.is_facing_right = not parent.is_facing_right
	else:
		parent.body.rotate_object_local(Vector3(0, 1, 0), -1*parent.AMT_ROTATION)
		parent.is_facing_right = not parent.is_facing_right
	
	pass
#
func process_physics( delta : float ) -> _State:
	ctr_turn += 1

	input_vector = input.get_region_left_stick()

#	print(debugString,input_vector)
#	print(debugString,"Velocity Is: ",parent.velocity.x)
#	print(debugString,"Facing Right is ",parent.is_facing_right)
#	print(debugString,"Un-modified Input Vector: ",input_vector)
	
	if not parent.is_facing_right:
		input_vector.x *= -1
		
	if ctr_turn >= parent.FRAME_TURN_STEP:
		if regionJumpSquat.has_point(input_vector):
			return stateJumpSquat
		
		elif regionDash.has_point(input_vector):
#			print(debugString,"Go to Dash")
			return stateDash
		
	if ctr_turn >= parent.FRAME_TURN_STAND:
		debug(ctr_turn)
		if regionDeadzone.has_point(input_vector):
			debug("Should be idle after tiltTurn.")
			return stateIdle

		elif regionWalkSlow.has_point(input_vector):
	#		print("Debug - _idle.gd : Go to walkSlow")
			return stateWalkSlow
			
		elif regionTiltTurn.has_point(input_vector):
#			print(debugString,"Go to Tilt Turn")
			return stateTiltTurn
			
		elif regionSquat.has_point(input_vector):
			return stateSquat

#	else:
#		print(debugString,"None of the above")
#		print(debugString,"ctr :",ctr_turn)
#		return stateError

#	print("DeadzoneLeft: ",deadzoneLeft)
	return null

#func process_frame(delta : float ) -> _State:
#
#	return null
