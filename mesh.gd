@tool
extends MeshInstance3D

@export var update = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	create_mesh()
	pass

func create_mesh() -> void:
	var array_mesh = ArrayMesh.new()
	
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
	
	var p1_vertices = PackedVector3Array([
		Vector3(-5,0,5),
		Vector3(5,0,5),
		Vector3(5, 0, 0),
		Vector3(0, 0, -5),
		Vector3(-5,0,-5),
	])
	
	var p2_vertices = PackedVector3Array([
		Vector3(5,0,0),
		Vector3(5,0,-5),
		Vector3(0,0,-5),
	])
	
	var p1 = TriangularPlane.new(p1_vertices)
	var p2 = TriangularPlane.new(p2_vertices)
	
	var surf1 = p1.export_surface()
	var surf2 = p2.export_surface()
	
	array_mesh.add_surface_from_arrays(surf1["primitive"], surf1["mesh_array"])
	
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surf2["mesh_array"])
	#
	mesh = array_mesh
	
	var rotation_angle = PI / 2
	
	var new_planes = TransformFold.new().fold(
		Vector3(5, 0, 0), Vector3(0, 0, -5), rotation_angle, [[1, 1]], [p1, p2]
	)
	
	#for i in new_planes.length():
		#var curr_plane = new_planes[i]
		#
		#print("Plane: ")
		#print(i)
		#print("Points: ")
		#print(curr_plane.export_surface()["points"])
			
	var array_mesh1 = ArrayMesh.new()
	var surf11 = new_planes[0].export_surface()
	var surf21 = new_planes[1].export_surface()
	
	var mesh11 = surf11["mesh_array"]
	array_mesh1.add_surface_from_arrays(surf11["primitive"], surf11["mesh_array"])
	
	array_mesh1.add_surface_from_arrays(surf21["primitive"], surf21["mesh_array"])
	
	mesh = array_mesh1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
