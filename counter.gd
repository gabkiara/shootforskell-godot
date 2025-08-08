# counter.gd - This is your global counter script

extends Node

var wall_hit_counter: int = 0

# Function to increment the counter
func increment_counter(amount: int) -> void:
	wall_hit_counter += amount
	emit_signal("counter_updated")  # Optional: Emit signal to notify UI update

# Function to get the current counter value
func get_counter() -> int:
	return wall_hit_counter
