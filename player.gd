extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking = false
var locked_direction = 0.0

func _ready():
	position.y = 300


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 0.0
	if Input.is_action_pressed("move_left"):
		direction = -1.0
	if Input.is_action_pressed("move_right"):
		direction = 1.0
	
	if Input.is_action_just_pressed("attack_sword") and not is_attacking:
		is_attacking = true
		locked_direction = direction
		$Timer.start()
		$AnimatedSprite2D.stop()
		if is_on_floor():
			$AnimatedSprite2D.play("attack")
		else:
			$AnimatedSprite2D.play("attack_jump")
	if not is_attacking:
		if direction:
			if !$AnimatedSprite2D.is_playing():
				$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = direction < 0
			velocity.x = direction * SPEED
		else:
			$AnimatedSprite2D.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else: 
		if direction == locked_direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	move_and_slide()


func _on_timer_timeout():
	is_attacking = false
	$AnimatedSprite2D.stop()
