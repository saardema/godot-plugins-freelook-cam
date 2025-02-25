@tool
extends EditorPlugin

const AUTOLOAD_NAME = "FreelookCam"

func _enable_plugin():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/freelook-cam/freelook-cam.tscn")

func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)
