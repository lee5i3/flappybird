extends Node2D
class_name ScoreOverlay

@onready var score: Label = $Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.reset_game.connect(on_reset_game)
	

func on_reset_game():
	updateScore(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateScore(value):
	Global.current_score = value
	score.text = "Score: %s" % [value]
