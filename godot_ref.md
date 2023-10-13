# Unity - Godot API Quick Reference

## Godot Keyboard Shortcuts I Know And Love

| Key | Use |
|-----|-----|
| F5 | Run current project |
| F6 | Run current scene |
| F7 | Resume after pause |
| F9 | Toggle breakpoint |
| F10 | Step out |
| F11 | Step into |
| Ctrl  \ | Show hide recently opened files |
| Ctrl  S | |
| Ctrl  K | Comment a line |
| Ctrl R | Search/Replace current file |
| Ctrl F | Search current file |
| Shift Ctrl F | Find in files |
| Shift Ctrl R | Replace in files |
| Ctrl Shift F11 | Max space for editing |
| Ctrl + A | Add new node |
| Ctrl + Shift + A | Instantiate new node |

## Important Nodes

| Node | Purpose |
| -----| --------|
| Node3D | | Node with a transform |
| XROrigin3D | Origin of the world in VR |
| XRCamera3D | Tracked Camera in VR |
| DirectionalLight | |
| StaticBody3D | World rigid body |
| CollisionShape3D | Requred to respond to collisions. Set the Shape property |
| MeshInstance3D | 3D mesh renderer |
| CharacterBody3D | Kinematic rigid body |
| Timer | Node that send signals on an interval |
| Camera3D | |


## Transforms

| Movement | translate, move_slide, move_collide | 
| Setting the position | position =, transform.origin =, global_transform.origin = 
| Rotating | rotate, rotate_x, rotate_y, rotate_z |
| Setting the rotation | rotation = Vector3(x, y, z). This is in radians. Also can be done using transform.basis.rotated() and global_transform.basis.rotated(), or Basis ( Quaternion from ) | 

## Referencing other nodes

```Python
$"..".add_child(bullet) 
$CharacterBody3D/Turret/bulletSpawn.global_transform.basis
$Timer.start(1.0 / fireRate)
```

## GDScript Reference 


|Code | Description                                            |
|-----------------------------------------|----------------------------------------------------------------|---|
| func _ready():                                              |  |
| if condition:  else:                                     |  |
| if condition:  elif:                                     |  |
| for i in range(length):                                  |  |
| while condition:                                          |  |
| var i = 0                                                      | |
| var f = 0.0                                                    | | 
| var v = Vector3(1, 2, 3)                                       | |
| @export var bulletPrefab:PackedScene | Give a node a reference to a packedscene (prefab) that can be instiantiated later | 
| var bullet = bulletPrefab.instantiate() | Create a new node from a packedscene
|
| class_name MyClass extends Node: ...                            |
| Something.new()
| func my_method(): ...                                          |
| get_node("/path/to/node").get_node("MyComponent")               |
| var rigidbody = get_node("/path/to/node").get_node("RigidBody") |
| yield(get_tree().create_timer(duration), "timeout")            | This is a coroutine. Timers are better |
| Input.is_action_pressed("ui_accept")                           |
| global_translation *or* global_transform.origin                                                      |
| var basis = global_transform.basis *or* var rot = Quat(global_transform.basis) *or* var rot = global_transform.basis.rotation_quat()                                       |
| global_transform.basis.scale                                                 |
| transform.origin |
| transform.basis |
| delta *or* get_process_delta_time() |
| global_transform.translate() *or* transform.translate() |
| rotate *or* rotate_object_local |
| global_transform.looking_at(boid.global_transform.origin, Vector3.UP) |
| a.dot(b)                                                 |
| a.cross(b)                                               |
| v.normalized()                                           |
| v.length()                                               |
| a.distance_to(b)                                         |
| from.angle_to(to)                                        |
| v.clamped(max)                                           |
| a.linear_interpolate(b, t)                                |
| inDirection.reflect(inNormal)  | 
| Vector3.UP
| Vector3.RIGHT |
| Vector3.FORWARD *Note this is (0, 0, -1) in Godot* |
| rand_range() *In Godot, call randomize() once in your program to set the random seed* |
| basis.slerp or quat.slerp |
| basis.xform() |
| DebugDraw.draw_sphere(target.global_transform.origin, slowing_radius, Color.aquamarine) |
| DebugDraw.draw_line(boid.global_transform.origin, feeler.hit_target, Color.chartreuse) *or* DebugDraw.draw_arrow_line(feeler.hit_target, feeler.hit_target + feeler.normal, Color.blue, 0.1) |

get_parent()
find_child()

@tool
@export