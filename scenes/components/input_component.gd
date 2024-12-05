extends Node2D
class_name InputComponent

@export var player:Player

signal flap

func _input(event: InputEvent) -> void:
	if Global.is_game_ended:
		return;
	
	if Input.is_action_just_pressed("flap"):
		if !flap.is_null():
			flap.emit()
