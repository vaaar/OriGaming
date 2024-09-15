extends Camera3D



var update_frame = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_origin_view()
	pass


func set_origin_view(point_to_face = Vector3(0,0,0)):
	look_at(point_to_face)

func rotate_through_vertical_axis(angle: float):
	rotate_y(deg_to_rad(angle))
	
func rotate_through_horizontal_axis(angle: float):
	rotate_x(deg_to_rad(angle))
	

func get_spherical():
	var z = position.z
	var x = position.x
	var y = position.y
	
	var rho = sqrt(z ** 2 + x ** 2 + y ** 2)
	var theta = atan2(x, z)
	var phi = acos(z/rho)
	
	print("rho: %f, theta: %f, phi: %f" % [rho, theta, phi])
	
	return [rho, theta, phi]

 #rho, theta, phi
   #0      1    2
func convert_to_cartesian(coords):
	var x = coords[0] * sin(coords[2]) * cos(coords[1])
	var z = coords[0] * sin(coords[2]) * sin(coords[1])
	var y = coords[0] * cos(coords[2])
	
	print("x: %f, y: %f, z: %f" % [x, y, z])
	
	#var x = 
	
	return [x, z, y]

# Called every frame. 'delta' is the elapsed time since the previous frame.
# kidscancode.org/godot_recipes/3.x/3d/camera_gimbal/index.html
func _process(delta: float) -> void:
	#var spherical_coords = get_spherical()
	#var curr_vec = position
	#var speed = 10
	#var multiplier = 0.02
	#var rotated_v = Vector3()
	#var rot_ang = PI/6
	#var y_rot = 0;
	#var x_rot = 0;
	#if Input.is_key_pressed(KEY_LEFT):
		##rotate_through_vertical_axis(-speed * delta)
		##spherical_coords[0] += -speed * multiplier
		##rotated_v = curr_vec.rotated(Vector3(0,1,0).normalized(), -rot_ang)
		##update_frame = true
		#y_rot -= 1
	#elif Input.is_key_pressed(KEY_RIGHT):
		##rotate_through_vertical_axis(speed * delta)
		##spherical_coords[0] += speed * multiplier
		##rotated_v = curr_vec.rotated(Vector3(0,1,0).normalized(), rot_ang)
		##update_frame = true
		#y_rot += 1
	#elif Input.is_key_pressed(KEY_UP):
		##rotate_through_horizontal_axis(-speed * delta)
		##spherical_coords[2] += -speed * multiplier
		##update_frame = true
		#x_rot -= 1
	#elif Input.is_key_pressed(KEY_DOWN):
		##rotate_through_horizontal_axis(speed * delta)
		##spherical_coords[1] += speed * multiplier
		##update_frame = true
		#x_rot += 1
	#$InnerGimbal.rotate_object_local(Vector3.UP, y_rot * rotation_speed * delta)
	#$OuterGimbal.rotate_object_local(Vector3.RIGHT, x_rot * rotation_speed * delta)
	pass
	
	#if update_frame:
		#var cartesian_coords = convert_to_cartesian(spherical_coords)
		#position.z = cartesian_coords[0]
		#position.x = cartesian_coords[1]
		#position.y = cartesian_coords[2]
		#print(curr_vec)
		#print(rotated_v)
		#position = rotated_v
		#update_frame = false
