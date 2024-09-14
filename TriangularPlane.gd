class_name TriangularPlane

<<<<<<< HEAD
var points_arr = PackedVector3Array()
var indices_arr = PackedInt32Array()
=======
var _points_arr = PackedVector3Array()
var _indices_arr = PackedInt32Array()
>>>>>>> 0c830aa (change var names in triangularplane)

func _init(plane_points: PackedVector3Array):
	for index in len(plane_points):
		var curr_point = plane_points[index]
		
		if index > 1:
<<<<<<< HEAD
			indices_arr.push_back(0)
			indices_arr.push_back(index)
			indices_arr.push_back(index - 1)
			
		points_arr.push_back(curr_point)
	
	print("Hello world\n")	
	print("Points:")
	print(points_arr)
	
	print("Indices:")
	print(indices_arr)
=======
			_indices_arr.push_back(0)
			_indices_arr.push_back(index)
			_indices_arr.push_back(index - 1)
			
		_points_arr.push_back(curr_point)
	
	print("Hello world\n")	
	print("Points:")
	print(_points_arr)
	
	print("Indices:")
	print(_indices_arr)
>>>>>>> 0c830aa (change var names in triangularplane)
	
func export_surface():
	var array = []
	array.resize(Mesh.ARRAY_MAX)
<<<<<<< HEAD
	array[Mesh.ARRAY_VERTEX] = points_arr
	array[Mesh.ARRAY_INDEX] = indices_arr
=======
	array[Mesh.ARRAY_VERTEX] = _points_arr
	array[Mesh.ARRAY_INDEX] = _indices_arr
>>>>>>> 0c830aa (change var names in triangularplane)
	
	return {
		"primitive": Mesh.PRIMITIVE_TRIANGLES,
		"mesh_array": array,
<<<<<<< HEAD
		"points": points_arr,
		"indices": indices_arr,
=======
		"points": _points_arr,
		"indices": _indices_arr,
>>>>>>> 0c830aa (change var names in triangularplane)
	}
