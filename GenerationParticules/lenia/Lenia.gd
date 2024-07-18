extends Node
class_name Lenia

@export var sprite : Sprite2D

@export_category("Lenia properties")
@export_range(100,1000,1) var image_width : int = 100
@export_range(100,1000,1) var image_height : int = 100

@onready var rd : RenderingDevice = RenderingServer.create_local_rendering_device()

# var shader_file : Resource
# var shader_spirv : RDShaderSPIRV
var shader : RID
var pipeline : RID
var compute_list : int

var pass_texture : RID

var mouse_pos = [-1,-1]
var mouse_clicked: bool = false

func _ready():
	sprite.texture = ImageTexture.create_from_image(create_image(image_width, image_height))
	shader = load_shader("res://lenia/Lenia.glsl")



	pass_texture = get_texture_rid(sprite.texture)
	


	# var uniform_set = rd.uniform_set_create([get_texture_uniform(sprite.texture, 0)], shader, 0)

	pipeline = rd.compute_pipeline_create(shader)
	
	rd.submit()
	rd.sync()

	# var output_texture = rd.texture_get_data()
	

func _process(_delta):
	if mouse_clicked:
		var local_pos = sprite.get_local_mouse_position()
		local_pos.x += ceil(sprite.texture.get_width() / 2)
		local_pos.y += ceil(sprite.texture.get_height() / 2)
		mouse_pos = [local_pos.x, local_pos.y]
	else:
		mouse_pos = [-1,-1]
	var uniform_set = rd.uniform_set_create([get_texture_uniform(pass_texture, 0),get_mouse_pos_buffer_uniform(1)], shader, 0)
	compute_list = rd.compute_list_begin()
	rd.compute_list_bind_compute_pipeline(compute_list, pipeline)
	rd.compute_list_bind_uniform_set(compute_list, uniform_set, 0)
	rd.compute_list_dispatch(compute_list, ceil(image_width / 16.0),ceil(image_height / 16.0),1)
	rd.compute_list_end()

	var byte_data : PackedByteArray = rd.texture_get_data(pass_texture, 0)
	var raw_image : Image = Image.create_from_data(image_width, image_height, false, Image.FORMAT_RGBAF, byte_data)
	sprite.texture = ImageTexture.create_from_image(raw_image)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_clicked = true
		else:
			mouse_clicked = false



func load_shader(path: String) -> RID:
	var shader_file : Resource = load(path)
	return rd.shader_create_from_spirv(shader_file.get_spirv())

func create_image(width: int, height: int) -> Image:
	var img : Image = Image.create(width, height, false, Image.FORMAT_RGBAF)
	for y in range(height):
		for x in range(width):
			img.set_pixel(x,y, Color(0,0,0,1))
	return img

func get_texture_rid(texture: Texture2D) -> RID:
	var fmt: RDTextureFormat = RDTextureFormat.new()
	fmt.width = texture.get_width()
	fmt.height = texture.get_height()
	fmt.format = RenderingDevice.DATA_FORMAT_R32G32B32A32_SFLOAT
	fmt.usage_bits = RenderingDevice.TEXTURE_USAGE_CAN_UPDATE_BIT | RenderingDevice.TEXTURE_USAGE_STORAGE_BIT | RenderingDevice.TEXTURE_USAGE_CAN_COPY_FROM_BIT
	var view : RDTextureView = RDTextureView.new()
	var tex : RID = rd.texture_create(fmt, view, [texture.get_image().get_data()])
	return tex

func get_texture_uniform(texture: RID, binding: int):
	var output_tex_uniform: RDUniform = RDUniform.new()
	output_tex_uniform.uniform_type = RenderingDevice.UNIFORM_TYPE_IMAGE
	output_tex_uniform.binding = binding
	output_tex_uniform.add_id(texture)
	return output_tex_uniform

func get_mouse_pos_buffer_uniform(binding: int):
	var input_data: PackedFloat32Array = PackedFloat32Array(mouse_pos)
	var input_bytes : PackedByteArray = input_data.to_byte_array()

	var buffer: RID = rd.storage_buffer_create(input_bytes.size(), input_bytes)
	
	var uniform : RDUniform = RDUniform.new()

	uniform.uniform_type = RenderingDevice.UNIFORM_TYPE_STORAGE_BUFFER
	uniform.binding = binding
	uniform.add_id(buffer)
	return uniform

