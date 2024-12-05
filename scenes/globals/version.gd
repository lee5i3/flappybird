extends Node

var version: String = "unknown"

func _ready():
	var file = FileAccess.open("res://build.txt", FileAccess.READ)
	if file:
		version = file.get_as_text()
		file.close()
	print("Build Date: ", version)
