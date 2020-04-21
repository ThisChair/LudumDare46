extends KinematicBody2D


const WALK_SPEED = 200
const WALK_ACC = 10
const GRAVITY = 15
const UP = Vector2(0,-1)
const JUMP_SPEED = 500
const INITIAL_LIGHT = 0.35

var lives = 70
var light_mod = 1

var velocity = Vector2()
var airborne = false

var on_water = false
var wave

var on_elevator = false

var _timer = null


func _ready():
	$Music.play()
	$Flame/Light2D.texture_scale = INITIAL_LIGHT
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _on_Timer_timeout():
	$Flame/Light2D.texture_scale -= 0.005 * light_mod
	lives -= 1 * light_mod
	

func _physics_process(delta):
	if lives == 0:
		get_tree().change_scene("res://GameOver.tscn")
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
	if on_elevator:
		velocity = Vector2(0,0)
	else:
		velocity = move_and_slide(velocity, UP)


func _on_Deep_body_entered(body):
	get_tree().change_scene("res://GameOver.tscn")
