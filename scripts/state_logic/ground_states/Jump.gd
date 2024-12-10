extends State

@export
var idleAir_state : State

@export
var jumpAir_state : State

@export
var airDash_state : State

@export
var idle_state : State

@export
var walk_state : State

# Placeholder; Nov 22nd, 2023
var jump_force_active = 50.0

func enter() -> void:
	super()
	parent.velocity.y = -jump_force_active

func process_physics(delta :float ) -> State:
	# I do want a maximum fall speed...
	parent.velocity.y += gravity*delta
	
	if parent.velocity.y > 0:
		return idleAir_state
	
	# Aerial Drift & Move Speed
	## Use this for now...
	var movement = Input.get_axis("move_left","move_right") * air_speed
	
#	# Place-Holder
#	if movement != 0:
#		parent.animations.flip_h = movement < 0
#	parent.velocity.x = movement
#	parent.move_and_slide()
	
	# Place-Holder / Place-Marking
	## Would like to include fast fall logic
	
	# Place_Holder
	## Would like to update for landing states based on velocity
	## I don't like these multi-return patterns...
	if parent.is_on_floor():
		if movement != 0:
			return walk_state
		return idle_state
		
	return null
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
