extends CharacterBody3D

@onready var tank = $"../tank"

@export var speed:float = 1

@export var time:float = 5

var to_target:Vector3

var t:float
var q1:Quaternion
var q2:Quaternion


func _ready():
	to_target = tank.position - position 
	speed = to_target.length() / time
	
	q1 = Quaternion.IDENTITY
	q2 = Quaternion()	
	

func _process(delta):
	DebugDraw.set_text("to_target", str(to_target))
	DebugDraw.set_text("Distance", str(to_target.length()))
	var dir = to_target.normalized()
	# look_at(-to_target)
	
	# var theta = to_target.angle_to(Vector3.BACK)
	# rotation = Vector3(0, theta, 0)
	
	var dot = dir.dot(Vector3.BACK)
	var theta = acos(dot)

	rotation = Vector3(0, theta, 0)
	
	# var q = Quaternion(Vector3.UP, theta)
	var q = q1.slerp(q2, t)
	print(q)
	transform.basis = Basis(q)
	if t < 1.0:
		t += delta * 0.1
	else:
		t = 1	
	print(t)
	
	var dot1 = transform.basis.z.dot(to_target)
	if dot1 >= 0:
		DebugDraw.set_text("Target is ", "in front")
	else:
		DebugDraw.set_text("Target is ", "behind")
			
	# position = position + dir * delta * speed
	# translate(dir * delta * speed)
	
