@tool
extends MeshInstance3D

@export var update = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	#$Camera
	#create_mesh()
	print("Current mesh???")
	print(mesh.to_string())
	pass

func create_mesh() -> void:
	#var array_mesh = ArrayMesh.new()
	
	#var test_vertices = PackedVector3Array(
		#[
			#Vector3(-10,0, 6),
			#Vector3(-5,0, 10),
			#Vector3(1,0, 11),
			#Vector3(5,0, 5),
			#Vector3(5,0, -5),
			#Vector3(-6,0, 1),
		#]
	#)
	
	#var test_vertices = PackedVector3Array(
		#[
			#Vector3(-5, 0, 5),
			#Vector3(5, 0, 5),
			#Vector3(-5, 0, -5)
		#]
	#)
	#
	#var tp = TriangularPlane.new(test_vertices)
	
	#var surf = tp.export_surface()
	#
	#var array = surf["mesh_array"]
	#array_mesh.add_surface_from_arrays(surf["primitive"], array)
	#
	#mesh = array_mesh
	
	#recreate_plane_scene([tp])
	
	self.global_transform.origin = Vector3(0,0,0)
	
func recreate_plane_scene(planes):
	var new_arraymesh = ArrayMesh.new()
	
	#for p: TriangularPlane in planes:
	for p_ind in range(len(planes)):
		var exp = planes[p_ind].export_surface()
		var next_mesh = exp["mesh_array"]
		new_arraymesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, next_mesh)
		new_arraymesh.surface_set_material (p_ind, preload("res://mesh_no_culling_mat.tres"))
	
	mesh = new_arraymesh
	
func rotate_through_vertical_axis(angle: float):
	rotate_y(deg_to_rad(angle))
	
func rotate_through_horizontal_axis(angle: float):
	rotate_x(deg_to_rad(angle))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = 100
	if Input.is_key_pressed(KEY_LEFT):
		rotate_through_vertical_axis(-speed * delta)
	elif Input.is_key_pressed(KEY_RIGHT):
		rotate_through_vertical_axis(speed * delta)
	elif Input.is_key_pressed(KEY_UP):
		rotate_through_horizontal_axis(-speed * delta)
	elif Input.is_key_pressed(KEY_DOWN):
		rotate_through_horizontal_axis(speed * delta)
