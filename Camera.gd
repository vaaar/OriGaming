extends Camera3D

var mesh_representation;

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

# Gets the mouse click. Uses it to compute world position. Uses that to create raycast. 
# If raycast hits object, the collision point is given to Mesh Representation.
func _input(event):
	if event is InputEventMouseButton:
		print("Mouse clicked.")
		$RayCast3D.target_position = project_position(event.position, 1000000)
		$RayCast3D.force_raycast_update()
		if $RayCast3D.is_colliding():
			var collision_point = $RayCast3D.get_collision_point()
			mesh_representation.on_point_click(collision_point)
			
			var fmt_str = "Collision point: %v"
			print(fmt_str % [collision_point])
