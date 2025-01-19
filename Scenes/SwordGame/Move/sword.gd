extends Node3D

signal sword_mouse_over()
signal sword_mouse_exit()

func _on_static_body_3d_mouse_entered():
	sword_mouse_over.emit()


func _on_static_body_3d_mouse_exited():
	sword_mouse_exit.emit()
