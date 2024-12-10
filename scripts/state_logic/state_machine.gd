extends Node

@export
var starting_state : State

var current_state : State

var previous_state : State

# Initialize the State Machine by giving each child state a reference to the parent object
# it belongs to and enter the defualt state
func init(parent: CharacterBody3D, move_component ) -> void:
#	print("DEBUG: 3rd Check")
	for child in get_children():
		child.parent = parent
		child.move_component = move_component
		
#	print("DEBUG: 4th Check")
	# Initialize to the Default State
	change_state(starting_state)

func change_state(new_state : State ) -> void:
	if current_state:
		current_state.exit()
	
	previous_state = current_state
	current_state = new_state
	current_state.enter()
	
# Passthrough Functions for each state to call
func process_physics( delta: float ) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input( event: InputEvent ) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)
		
func process_frame( delta: float ) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
