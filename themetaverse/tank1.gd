extends CharacterBody3D

@export var move_speed = 5
@export var rot_speed = 5

func _process(delta):	
		var move = Input.get_axis("move_forward", "move_backwards")
		var turn = Input.get_axis("move_left", "move_right")
		print(move)
		
		translate(Vector3.FORWARD * move * delta * move_speed)
		rotate(Vector3.UP, turn * rot_speed * delta)
