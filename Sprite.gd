extends AnimatedSprite

func _ready():
	connect("frame_changed", self, "_on_frame_changed")

func _on_frame_changed():
	if animation == 'Walk':
		$Step.play()
