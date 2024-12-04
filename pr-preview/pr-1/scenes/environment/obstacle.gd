extends Node2D

const SPEED = 196

func _physics_process(delta: float) -> void:	
	if Global.is_game_ended:
		return
	
	position.x += -SPEED * delta
	if global_position.x <= -200:
		print("Removing obstacle, off screen")
		queue_free()

func _on_score_area_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player has exited score area")
		Events.player_score.emit()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player has entered obstacle")
		Events.player_hit.emit()
