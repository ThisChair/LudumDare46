extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Wave_body_entered(body):
	body.on_water = true
	body.wave = $WaveAnimation

func _on_Wave_body_exited(body):
	body.on_water = false


func _on_WaveAnimation_animation_finished():
	$WaveAnimation.stop()
	$WaveAnimation.frame = 0
	


func _on_Enter_body_entered(body):
	$Enter/EnterAnimation.global_position.x = body.global_position.x
	$Splash.play()
	$Enter/EnterAnimation.play()


func _on_EnterAnimation_animation_finished():
	$Enter/EnterAnimation.stop()
	$Enter/EnterAnimation.frame = 0



func _on_WaveAnimation_frame_changed():
	if $WaveAnimation.frame == 2:
		$WaterStep.play()
