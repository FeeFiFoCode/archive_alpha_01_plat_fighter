extends Node
class_name Region

const REGION_PADDING = 0.0125
const INPUT_FUZZ = REGION_PADDING/2

var btm_left
var top_right

func _init(btm_left_incoming,top_right_incoming):
	btm_left = btm_left_incoming
	top_right = top_right_incoming
	pass

func has_point( input_vector ) -> bool:
	var check = false
	
	# Note - 3/22/2024
	## Because of the bounds, if top_right.x or top_right.y ( or both ) equal 1,
	## this code won't register them being in the region. So, I'm using "INPUT_FUZZ"
	## to slightly increase the region size along the top and right edges.
	
	# Note - 3/22/2024
	## Note, this INPUT_FUZZ needs to be smaller than any REGION_PADDING used.
	## As of writing this, the region padding is only loosely, but implicitly
	## integrated into the values used to call region initializations in the first place.
	## Ideally, a more robust solution solves this, especially since it's so error prone.
	if ( btm_left.x <= input_vector.x  and input_vector.x < top_right.x+INPUT_FUZZ ):
		if ( btm_left.y <= input_vector.y ) and ( input_vector.y < top_right.y+INPUT_FUZZ ):
			check = true
			

	return check
#
#func Region(btm_left,top_right) -> Rect2:
#	var width = top_right.x - btm_left.x
#	var height = top_right.y - btm_left.y
#
#	return Rect2(btm_left.x,btm_left.y,width,height)
