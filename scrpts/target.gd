extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var counter_label = $"../Label"  # Reference to the Label node
@onready var particles = $CPUParticles2D  # Reference to the Particles2D node
@onready var sfx_col: AudioStreamPlayer = $sfx_col

var speed: float = 300
var custom_velocity: Vector2 = Vector2.ZERO  # Rename to avoid conflict with the built-in 'velocity'
var corner_hit_chance: float = 0.25  # 25% chance to introduce randomness on collision

func _ready() -> void:
	particles.emitting = false
	custom_velocity = _random_up_direction() * speed
	update_counter_label()

func _random_up_direction() -> Vector2:
	var angle = deg_to_rad(randf_range(0, 180))
	return Vector2(cos(angle), sin(angle)).normalized()

func _physics_process(delta: float) -> void:
	var col = move_and_collide(custom_velocity * delta)
	
	if col:
		trigger_particles(col.get_position(), col.get_normal())
		counter.increment_counter(1)  # Increment counter by 1 for wall hit
		sfx_col.play()
		
		if is_corner_hit(col.get_normal()):
			counter.increment_counter(10)  # Increment by 10 for corner hit
			

		custom_velocity = custom_velocity.bounce(col.get_normal())
		update_counter_label()

func is_corner_hit(collision_normal: Vector2) -> bool:
	var threshold = 100
	var angle1 = Vector2(1, 0)
	var angle2 = Vector2(0, 1)
	var dot1 = collision_normal.dot(angle1)
	var dot2 = collision_normal.dot(angle2)
	return abs(dot1) > threshold or abs(dot2) > threshold

func update_counter_label() -> void:
	counter_label.text = str(counter.get_counter())  # Get counter from Counter singleton

func trigger_particles(collision_point: Vector2, collision_normal: Vector2) -> void:
	var sprite_width: float = 161
	var sprite_height: float = 75
	var offset_distance = 10  # Small offset for a cleaner effect
	
	# Apply the offset based on the collision normal
	var offset = collision_normal.normalized() * offset_distance
	var particle_position = collision_point + offset  # New position for particle emission

	var emit_area_size = Vector2.ZERO
	if collision_normal.x != 0:
		emit_area_size = Vector2(0, sprite_height)
		particles.global_position = Vector2(particle_position.x, sprite.global_position.y - sprite_height / 2)
	elif collision_normal.y != 0:
		emit_area_size = Vector2(sprite_width, 0)
		particles.global_position = Vector2(sprite.global_position.x - sprite_width / 2, particle_position.y)

	particles.scale = emit_area_size
	particles.emitting = true  # Start emitting particles

	# Emit particles for a short duration
	await get_tree().create_timer(0.1).timeout
	particles.emitting = false  # Stop emitting particles
