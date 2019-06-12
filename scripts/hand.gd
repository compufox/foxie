extends KinematicBody2D

onready var root = get_tree().root
onready var face = $"../fox"


func _process(delta):
	set_position(root.get_mouse_position())
	
	look_at(face.get_global_position())