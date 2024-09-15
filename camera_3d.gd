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
	

func cartesian_to_spherical(coord: Vector3):
	var rho = sqrt(pow(coord.x, 2) + pow(coord.z, 2) + pow(coord.y, 2))
	var theta = atan2(coord.z, coord.x)
	var phi = acos(coord.y/rho)
	
	return [rho, theta, phi]
	
func spherical_to_cartesian(coords):
	var rho = coords[0]
	var theta = coords[1]
	var phi = coords[2]
	
	var x = rho * sin(phi) * cos(theta)
	var z = rho * sin(phi) * sin(theta)
	var y = rho * cos(phi)
	
	return Vector3(x, y, z)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# kidscancode.org/godot_recipes/3.x/3d/camera_gimbal/index.html
func _process(delta: float) -> void:
	var curr_cartesian = position
	var curr_spherical = cartesian_to_spherical(curr_cartesian)
	var speed = 10
	var multiplier = 0.02
	
	if Input.is_key_pressed(KEY_LEFT):
		##rotate_through_vertical_axis(-speed * delta)
		curr_spherical[1] -= PI/6 * delta
		update_frame = true
		#y_rot -= 1
	elif Input.is_key_pressed(KEY_RIGHT):
		##rotate_through_vertical_axis(speed * delta)
		curr_spherical[1] += PI/6 * delta
		update_frame = true
	elif Input.is_key_pressed(KEY_UP):
		##rotate_through_horizontal_axis(-speed * delta)
		curr_spherical[2] -= PI/6 * delta
		update_frame = true
	elif Input.is_key_pressed(KEY_DOWN):
		##rotate_through_horizontal_axis(speed * delta)
		curr_spherical[2] += PI/6 * delta
		update_frame = true
	
	if update_frame:
		var new_cartesian = spherical_to_cartesian(curr_spherical)
		position = new_cartesian
		set_origin_view()
		update_frame = false
	
	if Input.is_action_just_pressed("click"):
		click(get_viewport().get_mouse_position())
	#if Input.is_action_just_pressed("click"):
		
		#var mousepos = get_viewport().get_mouse_position() + (Vector2.UP * get_viewport().get_visible_rect().size.y / 2)
		#mousepos = get_viewport().get_mouse_position()
		#print(get_viewport().get_visible_rect().size)
		#print(get_viewport().get_mouse_position())
		#$RayCast3D.target_position = project_position(mousepos, 100) - $RayCast3D.global_position
		#print("Mouse clicked.")
		#print($RayCast3D.target_position)
		#$RayCast3D.force_raycast_update()
		#if $RayCast3D.is_colliding():
			#var collision_point = $RayCast3D.get_collision_point()
			#get_node("../MeshRepresentation").on_point_click(collision_point)
			
			#var fmt_str = "Collision point: %v"
			#print(fmt_str % [collision_point])
			
			#var sphere = CSGSphere3D.new()
			#sphere.radius = 0.1
			#sphere.global_position = collision_point
			#get_parent().add_child(sphere)

# Gets the mouse click. Uses it to compute world position. Uses that to create raycast. 
# If raycast hits object, the collision point is given to Mesh Representation.
func _input(event):
	#if event is InputEventMouseButton:
	#click(event.position)
	pass

func click(mousepos):
	#mousepos = get_viewport().get_mouse_position()
	var raycast3d = get_node("../RayCast3D")
	raycast3d.global_position = global_position;
	raycast3d.target_position = project_position(mousepos, 100) - raycast3d.global_position
	print("Mouse clicked.")
	print(raycast3d.target_position)
	raycast3d.force_raycast_update()
	if raycast3d.is_colliding():
		print("COLLISION!")
		var collision_point = raycast3d.get_collision_point()
		get_node("../MeshRepresentation").on_point_click(collision_point)
		
		var fmt_str = "Collision point: %v"
		print(fmt_str % [collision_point])
		
		var sphere = CSGSphere3D.new()
		sphere.radius = 0.1
		sphere.global_position = collision_point
		get_parent().add_child(sphere)
