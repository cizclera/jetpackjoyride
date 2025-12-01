extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const MAX_VELOCIY = -400.0

var running : bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("up") and running == true :
		velocity.y = JUMP_VELOCITY
	
	#velocity cap
	if velocity.y > MAX_VELOCIY and Input.is_action_pressed("up"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()
