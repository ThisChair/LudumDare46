extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var player_passed = false
func _on_Player_detect_body_entered(body):
	if not player_passed:
		player_passed = true
		$Top.queue_free()
		$Blocker.set_collision_layer_bit(0,true)
