extends CharacterBody3D

# Variables
@export var speed: float = 10.0
@export var forward_movement: bool = true
@export var radius: float
@export var num_waypoints: int

var waypoints: PackedVector3Array = PackedVector3Array()

var current_waypoint_index: int = 0

func _ready():
	circular_waypoints();
	
	set_process(true)

func _process(delta: float):
	
	if forward_movement:
		move_tank_forward(delta)
	else:
		# move_tank_backward(delta)
		move_tank_forward(delta)

func move_tank_forward(delta: float):
	
	if current_waypoint_index < waypoints.size():
		var target_position = waypoints[current_waypoint_index]
		var move_direction = (target_position - global_transform.origin).normalized()
		velocity = move_direction * speed * delta
		global_transform.origin += velocity
		
		look_at(-target_position, Vector3(0, 1, 0))

		if global_transform.origin.distance_to(target_position) < 0.1:
			current_waypoint_index += 1

		if current_waypoint_index >= waypoints.size() - 1:
			current_waypoint_index = 0
			forward_movement = true
			current_waypoint_index += 1

func circular_waypoints():
	for i in range(num_waypoints):
		var angle = deg_to_rad(360.0 * i / num_waypoints)
		var x = cos(angle) * radius
		var z = sin(angle) * radius
		waypoints.append(Vector3(x, 0, z))
