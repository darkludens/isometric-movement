# Assuming this is a script attached to the Camera3D node.

extends Camera3D

@export var rotation_speed := 45.0 # degrees per rotation (adjustable)
@export var follow_distance := 10.0 # distance behind the player
@export var follow_height := 10.0 # height above the player

# Reference to the player, if not directly the parent
@onready var player := $".."

func _process(delta):
	# Follow the player with a smooth transition
	global_transform.origin = lerp(global_transform.origin, player.global_transform.origin - global_transform.basis.z * follow_distance + Vector3(0, follow_height, 0), delta * 5.0)

	# Rotate camera when Q or E is pressed
	if Input.is_action_just_pressed("rotate-left"):
		rotate_y(deg_to_rad(rotation_speed))
	elif Input.is_action_just_pressed("rotate-right"):
		rotate_y(deg_to_rad(-rotation_speed))
