extends CharacterBody2D
class_name Player       

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const START_POS:Vector2 = Vector2(100, 400)
const MAX_VELOCITY:int = 600
const GRAVITY:int = 2000
const FLAP_SPEED:int = -500

func reset():
	animated_sprite_2d.flip_v = false
	position = START_POS

func _physics_process(delta: float) -> void:
	if Global.is_game_running or Global.is_game_ended:	
		# Add the gravity.
		velocity.y += GRAVITY * delta
		if velocity.y > MAX_VELOCITY:
			velocity.y = MAX_VELOCITY
			Global.player_state = Global.PLAYER_STATE.FALLING
		else:
			Global.player_state = Global.PLAYER_STATE.FLYING
		
		move_and_collide(velocity * delta)
	
func flap():	
	velocity.y = FLAP_SPEED
	animated_sprite_2d.play()

func death():	
	Global.is_player_dead = true
	animated_sprite_2d.flip_v = true
