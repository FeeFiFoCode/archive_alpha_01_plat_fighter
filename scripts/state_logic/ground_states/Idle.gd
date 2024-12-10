extends State


@export
var idleAir_state : State

#@export
#var tipToe_state : State

@export
var walk_state : State

# Ideally, Run State is not something you get to via Idle
## I'd want dash -> run instead
## Just doing this for right though.
#@export
#var run_state : State
#
#@export
#var dash_state : State
#
#@export
#var qs_fwd_state : State
#
#@export
#var qs_back_state : State

@export
var squat_state : State

@export
var wavedash_state : State

@export
var jumpSquat_state : State

func enter() -> void:
	super()
## Will this work?
#	Date: Nov 22nd, 2023
#	Parent is "Player", which has script extending "CharacterBody3D"
	parent.velocity = Vector3(0,0,0)

func process_input(event: InputEvent ) -> State:
# is_on_floor is redundant, but may help with catching errors or weird interactions
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
#	if Input.is_action_just_pressed("jump"):
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return walk_state 
	if Input.is_action_just_pressed("crouch"):
		return squat_state
	if Input.is_action_just_pressed("wave_burst"):
		return wavedash_state
	return null

func process_physics(delta: float ) -> State:
# Adjust player y with gravity
## Is this ideal?
## Maybe more detail on move_and_slide() works with Player Type ( CharacterBody3D )
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return idleAir_state
	return null

	
	
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
