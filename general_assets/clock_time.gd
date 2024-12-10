extends Node

@onready
var timer := $Timer

@onready
var labelClock := $LabelClock

#func _ready() -> void:
#	timer.connect("timeout",label_timeout,"toggle_visibility")

func _process(delta: float) -> void:
#	print(roundi(timer.get_time_left()))
#	print( time_convert(roundi(timer.get_time_left())) )
	labelClock.set_text(time_convert( roundi( timer.get_time_left()) ) )
#	set_text("FPS %d" % Engine.get_frames_per_second())
		
		
func time_convert(time_in_sec):
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60
#	var hours = (time_in_sec/60)/60

#	#returns a string with the format "HH:MM:SS"
#	return "%02d:%02d:%02d" % [hours, minutes, seconds]
	return "%02d:%02d" % [minutes, seconds]
