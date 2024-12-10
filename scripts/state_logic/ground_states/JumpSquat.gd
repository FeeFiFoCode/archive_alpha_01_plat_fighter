extends State

@export
var idleAir : State

@export
var jump_state : State

# Should keep as a default parameter for a character
# Should make active-default distinction
const FRAME_COUNT_MAX_DEFAULT = 3
var frame_count_max_active = FRAME_COUNT_MAX_DEFAULT

var frameCtr = 1

const JUMP_FORCE_UNIT_DEFAULT = 8
var jump_force_unit_active = JUMP_FORCE_UNIT_DEFAULT
var jump_force_active = jump_force_unit_active

var jump_style = "linear"

func _physics_process(delta):
	# Jump Logic... probably a better way to handle
	# Also, what about continuous jump force application?
	
	
	if jump_style == "linear":
		jump_force_active += jump_force_unit_active
	elif jump_style == "constant":
		jump_force_active = jump_force_unit_active
	elif jump_style == "exponential":
		jump_force_active *= jump_force_unit_active
	else:
		# Weird Contingency
		jump_force_active = jump_force_unit_active
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
