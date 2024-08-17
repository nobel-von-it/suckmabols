extends CharacterBody2D

signal died

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking = false
var locked_direction = 0.0
var hp = 100.0

func _ready():
	update_hp_label()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if hp > 0:
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
				
		if position.y >= 800:
			take_damage(100)
				
		move_and_slide()


func _on_timer_timeout():
	is_attacking = false
	$AnimatedSprite2D.stop()

func update_hp_label():
	$HP.text = "HP: %d" % hp

func take_damage(amount):
	hp -= amount
	update_hp_label()
	if hp <= 0:
		died.emit()
