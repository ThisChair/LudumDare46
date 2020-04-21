extends KinematicBody2D

const FLY_SPEED = 150
const FLY_ACC = 15
const STOP_RADIUS = 35
const DETECTION_RADIUS = 150
const DAMAGE_RADIUS = 33

var target
var pursuit = false
var velocity = Vector2()
const UP = Vector2(0,-1)

func _physics_process(delta):
	target = get_node("../Player/Flame")
	var distance = global_position.distance_to(target.global_position)
	if distance < DETECTION_RADIUS:
		pursuit = true
	if pursuit:
		var direction = global_position.direction_to(target.global_position)
		var speed
		var player = get_node("../Player")
		if distance < DAMAGE_RADIUS:
			player.light_mod = 2
		else:
			if player.light_mod == 2:
				player.light_mod = 1
		if distance > STOP_RADIUS:
			speed = min(FLY_ACC + velocity.length(), FLY_SPEED)
		else:
			speed = lerp(velocity.length(), 0, 0.1)
		velocity = move_and_slide(speed*direction,UP)
