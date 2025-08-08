extends Node2D

# Reference to the target (DVD logo) node
@export var target: Node2D

func _ready():
	# Ensure the node will process input events
	set_process_input(true)

# Detect mouse click input
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Get the mouse click position (in world coordinates)
		var click_position = event.position
		
		# Pass the click effect to the target (DVD logo)
		if target:
			target.apply_click_effect(click_position)
