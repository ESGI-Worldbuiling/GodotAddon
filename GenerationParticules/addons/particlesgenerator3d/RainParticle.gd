@tool
extends GPUParticles3D

var count =0
# Called when the node enters the scene tree for the first time.
func _ready():
	count=0
	self.emitting=true
	
	var material = ParticleProcessMaterial.new()
	self.process_material = material
	var ribbon = RibbonTrailMesh.new()
	self.draw_pass_1 = ribbon
	var mat=StandardMaterial3D.new()
	ribbon.material=mat
	mat.transparency=BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.cull_mode=BaseMaterial3D.CULL_DISABLED
	mat.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.vertex_color_use_as_albedo
	mat.albedo_texture=load("res://addons/particlesgenerator3d/Textures/Circle.png")
	material.emission_shape=ParticleProcessMaterial.EMISSION_SHAPE_BOX
	material.emission_box_extents=Vector3(10,0.5,10)
	material.direction=Vector3(0,-1,0)
	material.spread=5
	material.initial_velocity_min=15
	material.initial_velocity_max=15
	material.collision_mode=ParticleProcessMaterial.COLLISION_RIGID
	material.color=Color("#b4d2dc")
	var min = Vector3(-10, -10, -10)
	var max = Vector3(20, 20, 20)
	self.visibility_aabb = AABB(min, max)
	var curveRibbon = Curve.new()
	curveRibbon.min_value=0.0
	curveRibbon.max_value=0.1
	curveRibbon.add_point(Vector2(0, 0))
	curveRibbon.add_point(Vector2(0.02,0.05))
	curveRibbon.add_point(Vector2(1.00, 0.00))
	ribbon.curve = curveRibbon
	self.amount=500
	self.lifetime=2
	self.randomness=1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rain_pressed():
	print(count)
	count +=1
	if count==1:
		self.emitting=true
	else: 
		count=0
		self.emitting=false
