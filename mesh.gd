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
	#var vertices := PackedVector3Array(
		#[
			#Vector3(-1,0,-1),
			#Vector3(1,0,-1),
			#Vector3(1,0,1),
			#
			#Vector3(-1,0,1),
			#
			#Vector3(0,0,1),
			#Vector3(1,0,0)
		#]
	#)
	#var indices := PackedInt32Array(
		#[
			#0,1,2,
			#
			##0,2,3
			#
			#
		#]
	#)
	#
	#var indices2 := PackedInt32Array(
		#[0,2,3]
	#)
	#
	#var array = []
	#array.resize(Mesh.ARRAY_MAX)
	#array[Mesh.ARRAY_VERTEX] = vertices
	#array[Mesh.ARRAY_INDEX] = indices
	#array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	#
	#array[Mesh.ARRAY_INDEX] = indices2
	#array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
<<<<<<< HEAD
	
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
	
	var test_vertices = PackedVector3Array([
		Vector3(-5,0,5),
		Vector3(5,0,5),
		Vector3(5,0,-5),
		#Vector3(-5,0,-5),
	])
	
	var tp = TriangularPlane.new(test_vertices)
	var ind_arr = tp.indices_arr
	var vert_arr = tp.points_arr
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vert_arr
	array[Mesh.ARRAY_INDEX] = ind_arr
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
=======
	
	var test_vertices = PackedVector3Array(
		[
			Vector3(-10,0, 6),
			Vector3(-5,0, 10),
			Vector3(1,0, 11),
			Vector3(5,0, 5),
			Vector3(5,0, -5),
			Vector3(-6,0, 1),
		]
	)
	
	#var test_vertices = PackedVector3Array([
		#Vector3(-5,0,5),
		#Vector3(5,0,5),
		#Vector3(5,0,-5),
		##Vector3(-5,0,-5),
	#])
	
	var tp = TriangularPlane.new(test_vertices)
	
	var surf = tp.export_surface()
	
	var array = surf["mesh_array"]
	array_mesh.add_surface_from_arrays(surf["primitive"], array)
>>>>>>> 0c830aa (change var names in triangularplane)
	
	mesh = array_mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
