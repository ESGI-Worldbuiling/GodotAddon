@tool
extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button # Replace with the path to your button
	if button:
		button.connect("pressed", Callable(self, "_on_button_pressed"))
		print("Button connected")
	else:
		print("Button not found")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	print("ehe")
	var path = "C://Program Files//Blender Foundation//Blender 4.0//blender.exe"
	var arguments = []
	var output = []
	var error = []
	var result = OS.execute(path, arguments, OS.PRE_EXECUTE)
	

	
