@tool
extends Node3D

@export var dod:PackedScene

@export var loops = 10.0
@export var r = 10.0
@export var num_loops = 10

func _ready():
	
	var radius = 1
	for i in range(1, loops + 1):
		var numPrefabs = 2.0 * PI * i * radius
		var theta = PI * 2.0 / numPrefabs
		for j in numPrefabs:
			var angle  = j * theta
			var x = sin(angle) * radius * i * 1.1
			var z = cos(angle) * radius * i * 1.1
			var james = dod.instantiate()
			james.transform.origin = Vector3(x, 0, z)
			
			var newMaterial = StandardMaterial3D.new()
			
			var h = j / numPrefabs
			newMaterial.albedo_color = Color.from_hsv(h, 1, 1, h)
			james.get_node("MeshInstance3D").material_override = newMaterial
			
			add_child(james)
			
func _process(delta):
	DebugDraw.draw_sphere(transform.origin, r, Color.BLUE)

