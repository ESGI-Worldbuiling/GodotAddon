@tool
extends GPUParticles3D

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	count = 0
	self.emitting = true
	

	var material = ParticleProcessMaterial.new()
	

	material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	material.collision_mode=ParticleProcessMaterial.COLLISION_RIGID
	material.lifetime_randomness=0
	material.initial_velocity_min=4
	material.initial_velocity_max=4
	material.scale_min=0.2
	material.scale_max=0.2
	material.direction=Vector3(0,-1,0)
	material.gravity=Vector3(0, -1, 0)
	var curve = Curve.new()
	curve.min_value=0
	curve.max_value=1
	curve.add_point(Vector2(0, 1))  # Point de départ
	curve.add_point(Vector2(0.09, 0.95))  # Point intermédiaire
	curve.add_point(Vector2(0.39,0.00))  # Point intermédiaire
	curve.add_point(Vector2(1, 0.02))  # Point final

	var curve_texture = CurveTexture.new()
	curve_texture.curve = curve
	

	material.angle_curve = curve_texture
	
	

	self.process_material = material
	

	self.lifetime = 5
	self.amount = 500
	self.randomness=0.5

	var sphere_mesh = SphereMesh.new()
	self.draw_pass_1 = sphere_mesh 
	draw_pass_1.radius=0.5
	draw_pass_1.Height=1

func _process(delta):
	pass

func _on_snow_pressed():
	count += 1
	if count == 1:
		self.emitting = true
	else: 
		count = 0
		self.emitting = false
