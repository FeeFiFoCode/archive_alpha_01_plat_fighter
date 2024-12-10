extends InputContract

# Controller Type ( varies for other controllers )
var controller_type = "Boxx"
#
## Input Sensitivity for Analog Inputs
### Left Stick
#### Sensitivities
#var sensitivity_left_stick = 1.0
#var sensitivity_left_stick_x = sensitivity_left_stick
#var sensitivity_left_stick_y = sensitivity_left_stick
#
### Signal Handling
#var left_x
#var left_y
#
#var sensitivity_right_stick = 1.0
#var sensitivity_right_stick_x = sensitivity_right_stick
#var sensitivity_right_stick_y = sensitivity_right_stick
#
#var sensitivity_left_trigger = 1.0
#var sensitivity_right_trigger = 1.0

var mod_x = 0.5
var mod_y = 0.5

# Get Regions
func get_region_left_stick() -> Vector2:
	# Handling Left Horizontal
	if Input.is_action_pressed("boxx_left") or Input.is_action_just_released("boxx_left"):
		left_x = -1
	elif Input.is_action_pressed("boxx_right") or Input.is_action_just_released("boxx_right"):
		left_x = 1
	else:
		left_x = 0
	
	# Handling Left Vertical
	if Input.is_action_pressed("boxx_up") or Input.is_action_just_released("boxx_up"):
		left_y = 1
	elif Input.is_action_pressed("boxx_down") or Input.is_action_just_released("boxx_down"):
		left_y = -1
	else:
		left_y = 0
		
	# Modifier Buttons
	if Input.is_action_pressed("boxx_mod_x"):
		left_x *= mod_x
	
	if Input.is_action_pressed("boxx_mod_y"):
		left_y *= mod_y
		
	return Vector2(left_x,left_y)
