extends MeshInstance3D

var speed = 1
var theta = 0

var start_pos:Vector3

func _ready():
	start_pos = position

func _physics_process(delta):
	var y = start_pos.y + sin(theta) * 10
	var new_pos = position
	new_pos.y = y
	position = new_pos	
	theta += delta
