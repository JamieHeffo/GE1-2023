extends Node3D

@onready var player:RigidBody3D = $"../../.."

@export var power = 100 

@export var trigger = 0 

func _physics_process(delta):
	if trigger > 0:
		var force = - global_transform.basis.y * power * trigger
		DebugDraw.draw_arrow_line(global_transform.origin, global_transform.origin + force, Color.ORANGE_RED, 0.1)
		player.apply_force(-force, Vector3.ZERO)

func _on_xr_controller_3d_input_float_changed(name, value):
	if name == "trigger":
		trigger =  value
#	
	pass # Replace with function body.


