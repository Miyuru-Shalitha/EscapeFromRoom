extends CharacterBody2D


@export var move_speed = 60.0
@export var jump_velocity = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 1200.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction -1, 0, 1
	var direction = Input.get_axis("left", "right")
	
	#play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("stop")
		else:
			animated_sprite.play("run")
	else :
		animated_sprite.play("stop")		
		
	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	
	#apply movements
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()
