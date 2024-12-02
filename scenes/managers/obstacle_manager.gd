extends Node2D
class_name ObstacleManager

@onready var timer: Timer = $Timer

var Obstacle = preload("res://scenes/environment/obstacle.tscn")

var obstacle_container: Node2D  # A container to hold obstacles

func _ready():
	randomize()
	# Create a container for obstacles if it doesn't already exist
	obstacle_container = get_node("ObstacleContainer") if has_node("ObstacleContainer") else Node2D.new()
	if not has_node("ObstacleContainer"):
		obstacle_container.name = "ObstacleContainer"
		add_child(obstacle_container)

func _on_timer_timeout() -> void:
	spawn_obstacle()
	
func spawn_obstacle():
	var obstacle = Obstacle.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	obstacle_container.add_child(obstacle)
	obstacle.position.y = randi() % 300 + 150

func clear_obstacles():
	for obstacle in obstacle_container.get_children():
		obstacle.queue_free()	

func start():
	timer.start()
	
func stop():
	timer.stop()
