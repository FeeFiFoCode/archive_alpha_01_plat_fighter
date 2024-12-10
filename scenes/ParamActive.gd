extends Node

# Test Script
# Consider Setting Up Logic for Active vs. Defualt Property Distinction
# Can use a Property Manager for Dynamic Property Management ( hp, etc )
@export
var x_sensitivity = 1.5

@export
var move_speed : float = 20

const MOVE_SPEED_MAX = 20
var move_speed_max = MOVE_SPEED_MAX / x_sensitivity
var move_speed_current : float

const CTR_WAVE_AIR = 3
var ctr_wave_air = CTR_WAVE_AIR

const MOVE_BASE_ACCEL = 5
var move_base_accel = MOVE_BASE_ACCEL

const MOVE_SCALE_ACCEL = 2
var move_scale_accel = MOVE_SCALE_ACCEL

const GRAVITY_FALLING = 50
var gravity_falling = GRAVITY_FALLING

const CTR_JUMP_MAX = 3
var ctr_jump = CTR_JUMP_MAX

var force_jump_air : float = 10.0

@export
var air_speed : float = 15
@export
var velocity_air_terminal : float = -30

@export
var traction : float = 0.06
var slipperiness : float = 1/traction
var facing_right = true

var waveGround_burst : float = 30
var waveAir_burst : float = 40

var accel_wave : float = .2
var accel_wave_air : float = 1

const METER_MAX : float = 100
const METER_MIN : float = 0
var meter : float = METER_MAX/2





@export
var gravity = 15
