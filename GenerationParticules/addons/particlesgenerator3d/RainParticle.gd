@tool
extends GPUParticles3D

var count =0
# Called when the node enters the scene tree for the first time.
func _ready():
	var material = ParticleProcessMaterial.new()
	self.process_material = material
	var ribbon = RibbonTrailMesh.new()
	self.draw_pass_1 = ribbon
	count=0
	self.emitting=true
	self.amount=500
	self.lifetime=2
	self.randomness=1
	self.visi
	self.trails=true
	self.trails_lifetime=0.2
	
	
	var emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	var curve = Curve.new()
	curve.add_point(Vector2(0, 0))
	curve.add_point(Vector2(0.5, 0.5))
	curve.add_point(Vector2(1, 1))
	var curve_texture = CurveTexture.new()
	curve_texture.curve = curve
	material.angle_curve = curve_texture
	draw_pass_1.curve = curve  # Apply the curve to the ribbon
	self.draw_pass_1 = ribbon
	material.direction=Vector3(0,-1,0)
	material.spread=2
	material.initial_velocity_min=15
	material.initial_velocity_max=15
	
	material.collision_mode=ParticleProcessMaterial.COLLISION_RIGID
	material.emission_shape = emission_shape
	material.spread = randf_range(0.1, 100)
	material.flatness = randf_range(0.1, 1.0)
	material.color="#b4d2dc"
	
	var min = Vector3(-10, -10, -10)
	var max = Vector3(20, 20, 20)
	self.visibility_aabb = AABB(min, max)
	
	var mat=StandardMaterial3D.new()
	draw_pass_1.material=mat
	mat.transparency=BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.cull_mode=BaseMaterial3D.CULL_DISABLED
	mat.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.vertex_color_use_as_albedo
	draw_pass_1.albedo_texture="res://addons/particlesgenerator3d/Textures/Circle.png"
	mat.use_particle_trails=true
	

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
