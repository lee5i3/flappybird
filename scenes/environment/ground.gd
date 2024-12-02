extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start() -> void:
	animation_player.play("scroll")

func stop() -> void:
	animation_player.stop()

func _on_hit_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		Events.player_hit.emit()
