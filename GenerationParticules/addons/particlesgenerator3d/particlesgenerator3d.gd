@tool
extends EditorPlugin

var dock_name = "Génération"
var dock : Control = null

func _enter_tree():
	dock = preload("res://addons/particlesgenerator3d/générer.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock)
	call_deferred("_add_custom_types")

func _exit_tree():
	remove_control_from_docks(dock)
	remove_custom_type("RainParticles")
	remove_custom_type("SnowParticles")
	remove_custom_type("FireParticles")
	dock.free()

func _add_custom_types():
	add_custom_type("RainParticles", "GPUParticles3D", preload("RainParticle.gd"), preload("icon.svg"))
	add_custom_type("SnowParticles", "GPUParticles3D", preload("SnowParticles.gd"), preload("icon.svg"))
	add_custom_type("FireParticles", "GPUParticles3D", preload("FireParticles.gd"), preload("icon.svg"))
