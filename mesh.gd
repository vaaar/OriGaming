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
	rotation = Vector3.ZERO
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
	var i = 0
	for plane in planes:
		var exp = plane.export_surface()
		var next_mesh = exp["mesh_array"]
		new_arraymesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, next_mesh)
		var new_mat = StandardMaterial3D.new();
		#new_mat.cull_mode = StandardMaterial3D.CullMode.CULL_DISABLED
		#new_mat.emission = Color(45, randi_range(0, 1), 62)
		new_arraymesh.surface_set_material(i, preload("res://mesh_no_culling_mat.tres"))
		#new_arraymesh.surface_set_material(i, new_mat)
		i += 1
	
	mesh = new_arraymesh
	create_trimesh_collision()
