# Extend the CharacterBody3D class
extends CharacterBody3D

# Variables
@export var speed: float = 10.0  # Movement speed of the character
@export var forward_movement: bool = true  # Flag indicating forward or backward movement
@export var radius: float  # Radius of the circular path
@export var num_waypoints: int  # Number of waypoints in the circular path

var waypoints: PackedVector3Array = PackedVector3Array()  # Array to store 3D waypoints
var current_waypoint_index: int = 0  # Index to track the current waypoint

# Function called when the node is added to the scene
func _ready():
	circular_waypoints()  # Initialize circular waypoints
	set_process(true)  # Enable the _process function

# Function called every frame
func _process(delta: float):
	if forward_movement:
		move_tank_forward(delta)  # Move character forward
	else:
		move_tank_forward(delta)  # Move character forward (backward movement is commented out)

# Move the character forward along the circular path
func move_tank_forward(delta: float):
	if current_waypoint_index < waypoints.size():
		# Get the target position (waypoint)
		var target_position = waypoints[current_waypoint_index]
		
		# Calculate movement direction
		var move_direction = (target_position - global_transform.origin).normalized()
		
		# Calculate velocity based on direction, speed, and delta time
		velocity = move_direction * speed * delta
		
		# Update the character's position
		global_transform.origin += velocity
		
		# Make the character look at the target position
		look_at(-target_position, Vector3(0, 1, 0))

		# Check if the character is close enough to the waypoint
		if global_transform.origin.distance_to(target_position) < 0.1:
			current_waypoint_index += 1

		# If the character reached the last waypoint, reset and start moving forward again
		if current_waypoint_index >= waypoints.size() - 1:
			current_waypoint_index = 0
			forward_movement = true
			current_waypoint_index += 1

# Generate circular waypoints based on the specified parameters
func circular_waypoints():
	for i in range(num_waypoints):
		# Calculate the angle for each waypoint
		var angle = deg_to_rad(360.0 * i / num_waypoints)
		
		# Calculate x and z coordinates for the circular path
		var x = cos(angle) * radius
		var z = sin(angle) * radius
		
		# Add the waypoint to the array
		waypoints.append(Vector3(x, 0, z))
