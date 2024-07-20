@tool
extends GPUParticles3D

var count =0
# Called when the node enters the scene tree for the first time.
func _ready():
	count=0
	self.emitting=false
	var material = ParticleProcessMaterial.new()
	var emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
	material.emission_shape = emission_shape
	material.spread = randf_range(0.1, 100)
	material.flatness = randf_range(0.1, 1.0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rain_pressed():
	count +=1
	if count==1:
		self.emitting=true
	else: 
		count=0
		self.emitting=false
