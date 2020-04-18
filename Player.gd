extends KinematicBody2D


const WALK_SPEED = 250
const WALK_ACC = 15
const GRAVITY = 15
const UP = Vector2(0,-1)
const JUMP_SPEED = 400

var velocity = Vector2()

func _physics_process(delta):
	$Flame.play("Burning")
	velocity.y += GRAVITY
	if (Input.is_action_pressed("ui_left")):
		$Sprite.flip_h = true
		velocity.x = max(velocity.x-WALK_ACC, -WALK_SPEED)
		$Sprite.play("Walk")
		$Flame.position.x = - abs($Flame.position.x)
	elif (Input.is_action_pressed("ui_right")):
		$Sprite.flip_h = false
		velocity.x = min(velocity.x+WALK_ACC, WALK_SPEED)
		$Sprite.play("Walk")
		$Flame.position.x = abs($Flame.position.x)
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0, 0.15)
		$Sprite.play("Idle")
	else:
		velocity.x = lerp(velocity.x, 0, 0.025)
		$Sprite.play("Idle")
	if is_on_floor():
		if Input.is_action_just_released("ui_accept"):
			velocity.y = -JUMP_SPEED
	else:
		$Sprite.play("Idle")
	velocity = move_and_slide(velocity, UP)
