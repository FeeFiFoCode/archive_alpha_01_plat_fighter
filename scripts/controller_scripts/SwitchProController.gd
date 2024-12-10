extends InputContract

# Controller Type ( varies for other controllers )
var controller_type = "Switch Pro Controller"

var contract_name = "Switch Pro Controller"
var debugString = "Debug: " + contract_name

## Input Sensitivity for Analog Inputs
### Left Stick
#### Sensitivities
#var sensitivity_left_stick = 1.0
#var sensitivity_left_stick_x = sensitivity_left_stick
#var sensitivity_left_stick_y = sensitivity_left_stick
#
#### Signal Handling
#var left_x = 0.0
#var left_y = 0.0
#
#var sensitivity_right_stick = 1.0
#var sensitivity_right_stick_x = sensitivity_right_stick
#var sensitivity_right_stick_y = sensitivity_right_stick
#
#var sensitivity_left_trigger = 1.0
#var sensitivity_right_trigger = 1.0

# Get Regions
func get_region_left_stick() -> Vector2:
	left_x = Input.get_joy_axis(0,JOY_AXIS_LEFT_X)*sensitivity_left_stick_x
	
	if left_x > 1:
		left_x = 1
	elif left_x < -1:
		left_x = -1
	else:
		pass
		
	left_y = -1 * Input.get_joy_axis(0,JOY_AXIS_LEFT_Y) * sensitivity_left_stick_y

	if left_y > 1:
		left_y = 1
	elif left_y < -1:
		left_y = -1
	else:
		pass

	return Vector2( left_x, left_y )
