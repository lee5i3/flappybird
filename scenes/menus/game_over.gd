extends Node2D

func _on_button_pressed() -> void:
	Events.reset_game.emit()