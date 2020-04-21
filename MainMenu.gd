
extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var new_game = true
var exit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Flame.play()
	$Flame.global_position.y = $HBoxContainer/VBoxContainer/NewGame.rect_global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
		if new_game:
			new_game = false
			$Flame.global_position.y = $HBoxContainer/VBoxContainer/Exit.rect_global_position.y
			exit = true
		else:
			new_game = true
			$Flame.global_position.y = $HBoxContainer/VBoxContainer/NewGame.rect_global_position.y
			exit = false
	if Input.is_action_just_pressed("ui_accept"):
		if new_game:
			print("New game")
			get_tree().change_scene("res://Instructions.tscn")
		else:
			print("Exit")
			get_tree().quit()
