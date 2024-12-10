class_name _Player
extends CharacterBody3D

@onready
var state_machine = $StateMachine

@onready
var animations = $Model/AnimationPlayer

@onready
var body = $Model

@onready
var input = $InputContract

@export
var character_name : String


@onready
var active_input_contract = SingletonInputContract.active_contract


#@onready
#var _animations = $Model.AnimationPlayer
#@onready
#var state_machine_attack = $StateMachineAttack
#@onready
#var move_component: Node = $MoveComponent

# Stats
const AMT_ROTATION = 3.14159


## Gen Gr Movement
#const TRACTION = -0.060*10
const TRACTION = -0.1*10

## Walk-Based
const WALK_SPEED_MAX = 1.50*10
const ACCEL_WALK_SCALE = 0.1*10
const ACCEL_WALK_BASE = 0.1*10

## Dash-Based
const DASH_SPEED_MAX = 2.50*10
const DASH_SPEED_INIT = 2.0*10
const ACCEL_DASH_SCALE = 0.015*10
const ACCEL_DASH_BASE = 0.01*10

## Run-Based
#const RUN_SPEED_MAX = 2.5*10
const RUN_SPEED_MAX = 2.50*10
const RUN_SPEED_INIT = 2.0*10
const ACCEL_RUN_SCALE = 0.015*10
const ACCEL_RUN_BASE = 0.05*10

## Jump-Based
const JUMP_SHORT_INIT = 2.0*10
const JUMP_FULL_INIT = 3.5*10

const JUMP_SUPER_INIT = ( JUMP_SHORT_INIT + JUMP_FULL_INIT )/2
#const JUMP_SUPER_INIT = 2.0*10
#const JUMP_SUPER_SCALE = 0.2*10
const JUMP_SUPER_SCALE = ( JUMP_FULL_INIT - JUMP_SUPER_INIT )/4

## Fall
const GRAVITY = -0.13*10
const FALL_MAX = -2.9*10
const FALL_FAST_MAX = -3.5*10

## Skid-Based
const SKID_SPEED_MAX = WALK_SPEED_MAX

var is_facing_right = true

# Max Frame Values
## Dash
const FRAME_DASH_STEP = 3
const FRAME_DASH_PRIME = 15 + FRAME_DASH_STEP
const FRAME_DASH_SEC = 4 + FRAME_DASH_PRIME
const FRAME_DASH_COOL = 9 + FRAME_DASH_SEC

## Turns
const FRAME_TURN_STEP = 0
const FRAME_TURN_STAND = 12

const FRAME_TURN_RUN_PRIME = 5
const FRAME_TURN_RUN_SEC = 1
const FRAME_TURN_RUN_TERT = 3

## Walks
const FRAME_PRE_DASH_STEP = 1

## Skid
const FRAME_SKID_BFR = 4

## Squat Times
const FRAME_SQUAT = 8
const FRAME_SQUAT_RV = 10

## Jump Squat Times
const FRAME_JUMP = 4
const FRAME_JUMP_SUPER = 7

# State-to-State Variables
var charge_jumpSuper

## Controller Sensitivities
#const REGION_PADDING = 0.0125
#const INPUT_FUZZ = REGION_PADDING/4


func _ready() -> void:
	print(character_name)
#	print(TestStaticData.itemData[character_name])
	
	print(input)
#	print("Debugging: ",$InputContract)

#	print("DEBUG: First Check")
	# Initialize State Machine
	# Pass reference of the player to the states
	# Makes it easier for player to move and react accordingly
#	state_machine.init(self,move_component)
	state_machine.init()
#	state_machine_attack.init(self,move_component)
	
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())
	
	input.set_script(load(active_input_contract))
#	print("DEBUG: Second Check")

func _unhandled_input(event: InputEvent ) -> void:
	state_machine.process_input(event)
#	state_machine_attack.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
#	state_machine_attack.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
