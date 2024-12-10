class_name Player
extends CharacterBody3D

@onready
var state_machine = $StateMachine
#@onready
#var state_machine_attack = $StateMachineAttack
@onready
var move_component: Node = $MoveComponent

func _ready() -> void:
#	print("DEBUG: First Check")
	# Initialize State Machine
	# Pass reference of the player to the states
	# Makes it easier for player to move and react accordingly
	state_machine.init(self,move_component)
#	state_machine_attack.init(self,move_component)
	
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())
#	print("DEBUG: Second Check")

func _unhandled_input(event: InputEvent ) -> void:
	state_machine.process_input(event)
#	state_machine_attack.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
#	state_machine_attack.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
#	state_machine_attack.process_frame(delta)


#const SPEED = 5.0
#const SPEED_GROUND_WAVE_BURST = 10.0
#const SPEED_AIR_WAVE_BURST = 20.0
#
#var actual_speed = 5.0
#
#const JUMP_VELOCITY = 8.0
#
#const AIR_JUMP_VELOCITY = 4.0
#const MAX_AIR_JUMPS = 2
#var CTR_AIR_JUMPS = MAX_AIR_JUMPS
#
### Get the gravity from the project settings to be synced with RigidBody nodes.
##var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#var gravity = 12.0
#
## Dash Logic
#var can_dash = false
#var is_dashing = false
#
#func _physics_process(delta):
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#
#	# Handle Jump.
#	## Ground Jump
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#	## Air Jump
#	if Input.is_action_just_pressed("jump") and not is_on_floor():
#		if CTR_AIR_JUMPS > 0:
#			velocity.y = AIR_JUMP_VELOCITY
#			CTR_AIR_JUMPS -= 1
#
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	#var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#
#	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#	var direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
#
#
#	if Input.is_action_just_pressed("wave_burst") and is_on_floor():
#		actual_speed = actual_speed + SPEED_GROUND_WAVE_BURST
#
#	if Input.is_action_just_pressed("wave_burst") and not is_on_floor():
#		actual_speed = actual_speed + SPEED_AIR_WAVE_BURST
#
#	if Input.is_action_just_released("wave_burst"):
#		actual_speed = SPEED
#
#	if direction:
#			velocity.x = direction.x * actual_speed
#			velocity.z = direction.z * actual_speed
#	else:
#		velocity.x = move_toward(velocity.x, 0, actual_speed)
#		velocity.z = move_toward(velocity.z, 0, actual_speed)
#
#
#	move_and_slide()
