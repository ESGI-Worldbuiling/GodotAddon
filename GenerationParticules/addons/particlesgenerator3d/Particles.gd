@tool
extends GPUParticles3D

func _enter_tree():
	self.emitting=false
func _generate_particles():

	var material = ParticleProcessMaterial.new()
	var emission_shapes = [ParticleProcessMaterial.EMISSION_SHAPE_POINT, ParticleProcessMaterial.EMISSION_SHAPE_SPHERE, ParticleProcessMaterial.EMISSION_SHAPE_BOX,ParticleProcessMaterial.EMISSION_SHAPE_RING]
	var random_index = randi() % emission_shapes.size()
	var emission_shape = emission_shapes[random_index]
	material.emission_shape = emission_shape
	material.spread = randf_range(0.1, 100)
	material.flatness = randf_range(0.1, 1.0)

	if emission_shape == ParticleProcessMaterial.EMISSION_SHAPE_SPHERE:
		material.emission_sphere_radius = randf_range(0.5, 100.0)
		
	material.gravity = Vector3(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))
	self.amount=randf_range(10, 1000)
	self.process_material = material
	var shape = random_mesh_shape()
	
	self.draw_pass_1=shape
	self.lifetime=randf_range(5.0, 50.0)
	
	var overlay_material = StandardMaterial3D.new()
	var random_color = Color(randf_range(0.0, 1.0), randf_range(0.0, 1.0), randf_range(0.0, 1.0))
	overlay_material.albedo_color = random_color
	
	self.material_override = overlay_material
	


func random_mesh_shape() -> Mesh:
	var shapes = [
		BoxMesh.new(),
		SphereMesh.new(),
		CapsuleMesh.new(),
		CylinderMesh.new(),
		
		QuadMesh.new(),  
		PrismMesh.new(), 
		PlaneMesh.new(),  
		
		TorusMesh.new(),  
	  
	]
	var random_index = randi() % shapes.size()
	return shapes[random_index]



func _process(delta):
	pass


func _on_button_pressed():
	self.emitting=true
	_generate_particles()


func _on_stop_pressed():
	self.emitting=false
