extends Area2D

@onready var sfx_corn: AudioStreamPlayer = $sfx_corn

func _ready() -> void:
	pass
	

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "target":  # Modify to match your sprite's name
		counter.increment_counter(10)  # Increment by 10 for corner hit
		sfx_corn.play()
