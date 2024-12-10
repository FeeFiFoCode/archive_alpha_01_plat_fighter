extends Node

const WALK_SPEED_MAX : float = 20
const WALK_ACCEL_BASE : float = 5
const WALK_ACCEL_SCALE : float = 2

const RUN_SPEED_MAX : float = 40
const DASH_SPEED_INIT : float = 25
const DASH_SPEED_MAX : float = 30
const RUN_DASH_SPEED_ACCEL : float = 5

const TRACTION : float = 0.06
const SLIPPERINESS : float = 1/TRACTION
const SKID : float = 2

const GRAVITY_FALL : float = 50
const GRAVITY_UP : float = 30

const FALL_SPEED_MAX : float = -30
const FALL_FAST_SPEED_MAX : float = -50

const JUMP_FORCE_GROUND : float = 30
const JUMP_FORCE_AIR : float = 10
const JUMP_CTR_AIR_MAX : int = 3

const JUMP_DRIFT : float = 5
const FALL_DRIFT : float = 10
const FALL_FRICTION : float = 1

const WAVE_GRND_FWD_INIT : float = 30
const WAVE_GRND_FWD_MAX : float = 40
const WAVE_GRND_FWD_ACCEL : float = 5

const WAVE_GRND_BACK_INIT : float = 20
const WAVE_GRND_BACK_MAX : float = 25
const WAVE_GRND_BACK_ACCEL : float = 1

const WAVE_GRND_UP_INIT : float = 40
const WAVE_GRND_UP_MAX : float = 45
const WAVE_GRND_UP_ACCEL : float = 1

const WAVE_AIR_FWD_INIT : float = 40
const WAVE_AIR_FWD_MAX : float = 50
const WAVE_AIR_FWD_ACCEL : float = 1

const WAVE_AIR_BACK_INIT : float = 20
const WAVE_AIR_BACK_MAX : float = 25
const WAVE_AIR_BCK_ACCEL : float = 1

const WAVE_AIR_UP_INIT : float = 15
const WAVE_AIR_UP_MAX : float = 25
const WAVE_AIR_UP_ACCEL : float = 5

const WAVE_AIR_DOWN_INIT : float = 20
const WAVE_AIR_DOWN_MAX : float = 30
const WAVE_AIR_DOWN_ACCEL : float = 5

const WAVE_AIR_CTR_MAX : int = 3

const METER_SYS_MAX : float = 200
const METER_SYS_MIN : float = 0

const METER_GEN_MAX : float = 100
const METER_GEN_MIN : float = 0

const METER_SHIELD_HARD_MAX : float = 100
const METER_SHIELD_HARD_MIN : float = 0
const METER_SHIELD_HARD_DEF : float = 5
const METER_SHIELD_HARD_SCALE : float = 0.9
const METER_SHIELD_HARD_PUSH : float = 1
const METER_SHIELD_HARD_DECAY : float = 1
const METER_SHIELD_HARD_STUN : float = 5

const METER_SHIELD_LIGHT_MAX : float = 200
const METER_SHIELD_LIGHT_MIN : float = 0
const METER_SHIELD_LIGHT_DEF : float = 5
const METER_SHIELD_LIGHT_SCALE : float = 0.9
const METER_SHIELD_LIGHT_PUSH : float = 1
const METER_SHELD_LIGHT_META : float = 1.1
const METER_SHIELD_LIGHT_DECAY : float = 2
const METER_SHIELD_LIGHT_STUN : float = 7
