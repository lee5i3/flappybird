extends Node

@onready var player: Player = $Player
@onready var obstacle_manager: ObstacleManager = $ObstacleManager
@onready var audio_manager: AudioManager = $AudioManager
@onready var score_overlay: ScoreOverlay = $ScoreOverlay
@onready var ground = $Ground

var screen_size:Vector2
var scroll:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	screen_size = get_viewport().get_visible_rect().size	
	Events.player_hit.connect(on_player_hit)
	Events.player_score.connect(on_player_score)
	Events.new_game.connect(on_new_game)	
	Events.reset_game.connect(on_reset_game)
	
	Events.reset_game.emit()	

func on_reset_game():
	# Stop Timers
	obstacle_manager.stop()	
	ground.stop()

	obstacle_manager.clear_obstacles()
	player.reset()
	Global.is_game_running = false
	Global.is_game_ended = false
	Global.current_score = 0
	score_overlay.updateScore(0)

	# Toggle Menus
	$StartMenu.show()
	$GameOver.hide()

func on_new_game():
	start_new_game()

func start_new_game():	
	$StartMenu.hide()
	
	Global.is_game_running = true
	Global.is_game_ended = false
	Global.is_player_dead = false
	obstacle_manager.start()
	ground.start()
	
func on_player_hit():
	if Global.is_game_ended == false:
		Global.is_game_ended = true
		Global.is_game_running = false
		obstacle_manager.stop()	
		ground.stop()
		player.death()
		# Menus
		$GameOver.show()	
		audio_manager.fairy_hit.play()

func on_player_score():
	audio_manager.score.play()
	Global.current_score += 1
	score_overlay.updateScore(Global.current_score)

func _input(event: InputEvent) -> void:
	if Global.is_game_ended:
		return;
	
	if Input.is_action_just_pressed("flap"):
		if !Global.is_game_running:
			Events.new_game.emit()
			
		if player.position.y < 0:
			Events.player_hit.emit()
		
		player.flap()
		audio_manager.fairy_flap.play()
