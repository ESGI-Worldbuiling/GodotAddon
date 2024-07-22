@tool
extends GPUParticles3D


var count =0
# Called when the node enters the scene tree for the first time.
func _ready():
	count=0
	self.emitting=false

	self.DRAW_ORDER_VIEW_DEPTH
	var material = ParticleProcessMaterial.new()
	self.process_material = material
	var curve = Curve.new()
	curve.min_value=-360
	curve.max_value=360
	curve.add_point(Vector2(0, -355.81))  # Point de départ
	curve.add_point(Vector2(0.55, 360.00))  # Point intermédiaire
	curve.add_point(Vector2(1.00,-351.63))  # Point intermédiaire
	curve.bake_resolution=80
	var curve_texture = CurveTexture.new()
	curve_texture.width=256
	curve_texture.curve = curve
	var curves=Curve.new()
	curves.add_point(Vector2(0.00, 0.01))  # Point de départ
	curves.add_point(Vector2(0.01, 0.98))  # Point intermédiaire
	curves.add_point(Vector2(1.00,0.00))
	var text=CurveTexture.new()
	text=curves
	material.scale_curve=text
	material.angle_curve = curve_texture
	material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
	material.angle_min=261.1
	material.angle_max=360
	material.inherit_velocity_ratio=1
	material.spread=0
	material.initial_velocity_min=5
	material.initial_velocity_max=5
	material.angular_velocity_min=40
	material.angular_velocity_max=40
	material.direction=Vector3(0,1,0)
	material.emission_sphere_radius=0.4
	
	var quad = QuadMesh.new()
	self.draw_pass_1 = quad
	var mat=StandardMaterial3D.new()
	quad.material=mat
	mat.transparency=BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.depth_draw_mode=BaseMaterial3D.DEPTH_DRAW_DISABLED
	mat.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.vertex_color_use_as_albedo=true
	mat.albedo_color=Color("#fe650d")
	mat.albedo_texture=load("res://addons/particlesgenerator3d/Textures/Smoke30Frames_0.png")
	mat.billboard_mode=BaseMaterial3D.BILLBOARD_PARTICLES
	mat.billboard_keep_scale=true
	self.amount=200
	self.randomness=1
	material.gravity=Vector3(0,0,0)
	
	material.anim_speed_min=1
	material.angular_velocity_max1
	material.anim_offset_min=1
	material.anim_offset_max=1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fire_pressed():
	count +=1
	if count==1:
		self.emitting=true
	else: 
		count=0
		self.emitting=false
