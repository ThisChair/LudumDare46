extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
