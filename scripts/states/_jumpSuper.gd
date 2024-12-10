extends _State

const nameState = "Super Jump"
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
var stateFall : _State

var mapRegionLeft = [
	[ regionDeadzone, stateIdle ],
]

func process_physics( delta : float ) -> _State:
#
#	input_vector = Vector2( Input.get_joy_axis(0,JOY_AXIS_LEFT_X), -1*Input.get_joy_axis(0,JOY_AXIS_LEFT_Y) )
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
#	if sign(parent.velocity.x) == sign(parent.velocity.x + accelApplied ):
#		parent.velocity.x += accelApplied
#	else:
#		parent.velocity.x = 0
#
	parent.velocity.y = parent.JUMP_SUPER_INIT + parent.JUMP_SUPER_SCALE*parent.charge_jumpSuper
	parent.move_and_slide()

	return stateFall

func exit():
	super()
	parent.charge_jumpSuper = 0
