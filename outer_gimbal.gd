extends Node3D

var rotation_speed = PI/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var y_rot = 0;
	var x_rot = 0;
	if Input.is_key_pressed(KEY_LEFT):
		y_rot -= 1
	elif Input.is_key_pressed(KEY_RIGHT):
		y_rot += 1
	elif Input.is_key_pressed(KEY_UP):
		x_rot -= 1
	elif Input.is_key_pressed(KEY_DOWN):
		x_rot += 1
	get_node("InnerGimbal").rotate_object_local(Vector3.UP, y_rot * rotation_speed * delta)
	rotate_object_local(Vector3.RIGHT, x_rot * rotation_speed * delta)
