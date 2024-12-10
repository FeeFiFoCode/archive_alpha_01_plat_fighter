extends _State

const nameState = "Fall"
var debugString = "Debug - " + nameState + ": "

# Regions
var regionDeadzone = Region.new(Vector2(-0.2750,-0.6500), Vector2(0.2750,0.6500) )
var regionWalkSlow = Region.new(Vector2(0.2875,-0.6500), Vector2(0.7875,0.6500))

var regionTiltTurn = Region.new(Vector2(-0.7875,-0.6500), Vector2(-0.2875,0.6500))

var regionDash = Region.new(Vector2(0.8000,-0.6500),Vector2(1.000,0.6500))
var regionDashBack = Region.new(Vector2(-1.000,-0.6500),Vector2(-0.8000,0.6500))

var regionJumpSquat = Region.new(Vector2(-1.000,0.6625),Vector2(1.000,1.000))
var regionSquat = Region.new(Vector2(-0.7875,-1.000),Vector2(0.7875,-0.6625))

# 
var input_vector
var accelApplied = 0

#func enter() -> void:
#	super()

#
@export
var stateIdle : _State

#var stateFall : _State

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

@export
var stateDashBack : _State

var mapRegionLeft = [
	[ regionDeadzone, stateIdle ],
	[ regionWalkSlow, stateWalkSlow ],
	
	[ regionTiltTurn, stateTiltTurn ],
	
	[ regionDash , stateDash ],
	[ regionDashBack, stateDashBack ],
	
	[ regionJumpSquat, stateJumpSquat ],
	[ regionSquat, stateSquat ]
]

func process_physics( delta : float ) -> _State:
#	print(debugString,"Current Fall Speed: ",parent.velocity.y)

	if parent.is_on_floor():
		return stateIdle

	input_vector = input.get_region_left_stick()
#


##	print(debugString,input_vector)
##	print(debugString,"Velocity Is: ",parent.velocity.x)
##	print(debugString,"Facing Right is ",parent.is_facing_right)
##	print(debugString,"Un-modified Input Vector: ",input_vector)
#
#	if not parent.is_facing_right:
#		input_vector.x *= -1
#
#	if regionDeadzone.has_point(input_vector):
##		print(debugString,"Stay in Idle")
#		pass
#
#	elif regionWalkSlow.has_point(input_vector):
##		print(debugString,"Go to walkSlow")
#		return stateWalkSlow
#
#	elif regionTiltTurn.has_point(input_vector):
##		print(debugString,"Go to Tilt Turn")
#		return stateTiltTurn
#
#	elif regionDash.has_point(input_vector):
##		print(debugString,"Go to Dash")
#		return stateDash
#
#	elif regionDashBack.has_point(input_vector):
##		print(debugString,"Go to Dash Back")
#		return stateDashBack
#
#	elif regionJumpSquat.has_point(input_vector):
##		print(debugString,"Go to JumpSquat")
#		return stateJumpSquat
#
#	elif regionSquat.has_point(input_vector):
##		print(debugString,"Go to Squat")
#		return stateSquat
#
#	else:
#		print(debugString,"None of the above")
#		print(debugString,"Velocity Is: ",parent.velocity.x)
#		print(debugString,"Facing Right is ",parent.is_facing_right)
#		print(debugString,"Modified Input Vector: ",input_vector)
#
##	print("DeadzoneLeft: ",deadzoneLeft)
#
##	print("Horizontal Velocity: ",parent.velocity.x)
##	print("Body: ")
#
#	if parent.velocity.x > parent.WALK_SPEED_MAX:
#		accelApplied = 2*parent.TRACTION
#
#	elif parent.velocity.x > 0:
#		accelApplied = parent.TRACTION
#
#	elif parent.velocity.x < -1*parent.WALK_SPEED_MAX:
#		accelApplied = -2 * parent.TRACTION
#
#	elif parent.velocity.x < 0:
#		accelApplied = -1 * parent.TRACTION
#	else:
#		pass
#
#	# Check if accelerating will cross 0.
#	## If it does not, then just acceelerate as normal.
#	## If it does, then just set velocity to 0.
#
	if parent.velocity.y + parent.GRAVITY < parent.FALL_MAX:
		parent.velocity.y = parent.FALL_MAX
	else:
		parent.velocity.y += parent.GRAVITY

	parent.move_and_slide()

	return null
