extends Node

enum GAME_STATE { GAME_OVER, PAUSED, RUNNING, WAITING_ON_INPUT }
enum PLAYER_STATE { FLYING, FALLING }

const SCROLL_SPEED = 2
const JUMP_VELOCITY = -250.0

var _game_state:GAME_STATE
var player_state:PLAYER_STATE

var is_game_running:bool
var is_game_initialized:bool
var is_game_ended:bool
var is_player_dead:bool

var current_score:int = 0
