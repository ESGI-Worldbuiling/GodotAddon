@tool
extends GPUParticles3D


var count =0
# Called when the node enters the scene tree for the first time.
func _ready():
	count=0
	self.emitting=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_snow_pressed():
	count +=1
	if count==1:
		self.emitting=true
	else: 
		count=0
		self.emitting=false

