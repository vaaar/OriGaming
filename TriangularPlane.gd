class_name TriangularPlane

var _points_arr = PackedVector3Array()
var _indices_arr = PackedInt32Array()

func _init(plane_points: PackedVector3Array):
	for index in len(plane_points):
		var curr_point = plane_points[index]
		
		if index > 1:
			_indices_arr.push_back(0)
			_indices_arr.push_back(index)
			_indices_arr.push_back(index - 1)
			
		_points_arr.push_back(curr_point)
	
	print("Hello world\n")	
	print("Points:")
	print(_points_arr)
	
	print("Indices:")
	print(_indices_arr)
	
func export_surface():
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = _points_arr
	array[Mesh.ARRAY_INDEX] = _indices_arr
	
	return {
		"primitive": Mesh.PRIMITIVE_TRIANGLES,
		"mesh_array": array,
		"points": _points_arr,
		"indices": _indices_arr,
	}
