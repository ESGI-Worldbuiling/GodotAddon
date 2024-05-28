@tool
extends EditorPlugin

var dock_name = "Génération"
var dock : Control = null

func _enter_tree():
	dock = preload("res://addons/particlesgenerator3d/générer.tscn").instantiate()
	
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock)
	
	
func _exit_tree():

	remove_control_from_docks(dock)

	dock.free()
