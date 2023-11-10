extends Node

@export var target_path:NodePath
@export var player_path:NodePath
var target
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(target_path)
	player = get_node(player_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# transform.origin += transform.basis.z
#	player.global_position = lerp(player.global_position, target.global_position, delta * 5)
#	player.look_at(target.get_parent_node_3d().global_position, Vector3.UP)
	pass
