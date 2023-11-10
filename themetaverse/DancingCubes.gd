extends Node3D

var dancing_cube = preload("res://dancing_cube.tscn")
var spectrum : AudioEffectSpectrumAnalyzerInstance
const num_cubes = 64
func _ready():
	var radius = 1
	spectrum = AudioServer.get_bus_effect_instance(AudioServer.get_bus_index("Music"), 0)
	var player :  AudioStreamPlayer = get_node("../XROrigin3D/XRCamera3D/AudioStreamPlayer")
	player.seek(50)
	for i in range(num_cubes):
		var b = dancing_cube.instantiate()
		
		var angle : float = deg_to_rad( float(i)  * (360./float(num_cubes)))
		b.position.x = radius * cos(angle)
		b.position.z = radius * sin(angle)
		var c : MeshInstance3D = b.get_child(0)
		
		c.set_material_override(c.get_active_material(0).duplicate())
		#c.get
		add_child(b)
		b.look_at(position,Vector3.UP)
		
const FREQ_MAX = 11050.0
const MIN_DB = 60
var offs = 0.0
var rng = RandomNumberGenerator.new()
var overall_magnitude = 0.
func _physics_process(delta):
	var prev_hz = 120.
	overall_magnitude = spectrum.get_magnitude_for_frequency_range(40, FREQ_MAX).length()
	#overall_magnitude = lerp (overall_magnitude, spectrum.get_magnitude_for_frequency_range(40, FREQ_MAX).length(),  0.05)
	for i in range(num_cubes):
		# var hz = (float(i) * FREQ_MAX / float(num_cubes)) + 120.
		var hz = 2.75 * float(i) * float(i) + 40. 
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = float(clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1))
		var current_child = get_child(i)
		
		var f = fmod((hz / FREQ_MAX) + offs, 1.)
		current_child.get_child(0).get_active_material(0).albedo_color = Color.from_hsv( f * overall_magnitude,1,1)
		
		
		
		current_child.scale.y =  lerp( current_child.scale.y, energy, 0.5) + 0.001
		prev_hz = hz

	offs += delta
