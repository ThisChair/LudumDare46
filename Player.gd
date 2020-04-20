extends KinematicBody2D


const WALK_SPEED = 200
const WALK_ACC = 10
const GRAVITY = 15
const UP = Vector2(0,-1)
const JUMP_SPEED = 500

var velocity = Vector2()
var airborne = false

var on_water = false
var wave

func _physics_process(delta):
	$Flame.play("Burning")
	velocity.y += GRAVITY
	if (Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")) and not airborne:
		$Sprite/Step.play()
	if (Input.is_action_pressed("ui_left")):
		$Sprite.flip_h = true
		velocity.x = max(velocity.x-WALK_ACC, -WALK_SPEED)
		$Sprite.play("Walk")
		$Flame.position.x = - abs($Flame.position.x)
		if on_water:
			wave.play()
	elif (Input.is_action_pressed("ui_right")):
		$Sprite.flip_h = false
		velocity.x = min(velocity.x+WALK_ACC, WALK_SPEED)
		$Sprite.play("Walk")
		$Flame.position.x = abs($Flame.position.x)
		if on_water:
			wave.play()
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0, 0.15)
		$Sprite.play("Idle")
	else:
		velocity.x = lerp(velocity.x, 0, 0.025)
		$Sprite.play("Idle")
	if is_on_floor():
		if airborne:
			airborne = false
			$FloorSound.play()
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -JUMP_SPEED
			$JumpSound.play()
	else:
		$Sprite.play("Idle")
		airborne = true
	velocity = move_and_slide(velocity, UP)
