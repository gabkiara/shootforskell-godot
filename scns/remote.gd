extends Area2D

@onready var shop = $ShopMenu  # Reference to the ShopMenu node
@onready var sprite = $AnimatedSprite  # Reference to the animated sprite for the remote

# The 'click' action is defined in the Input Map, so we check it directly using Input.is_action_pressed() or _input()
func _ready():
	# Ensure that the Area2D node listens for input events (this is typically enabled by default)
	self.input_pickable = true
	
	# Optionally, you could set this to connect an input signal (but the _on_input_event method below should be sufficient)
	# self.connect("input_event", self, "_on_input_event")

func _on_input_event(_viewport, event, _shape_idx):
	# Check if the event is a mouse button press and if it's the left click (you mentioned 'click' is defined in the Input Map)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Toggle the shop visibility when the remote icon is clicked
		shop.toggle_shop()
