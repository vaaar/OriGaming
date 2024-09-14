class_name TriangularPlane

var points_arr = PackedVector3Array()
var indices_arr = PackedInt32Array()

func _init(plane_points: PackedVector3Array):
	for index in len(plane_points):
		var curr_point = plane_points[index]
		
		if index > 1:
			indices_arr.push_back(0)
			indices_arr.push_back(index)
			indices_arr.push_back(index - 1)
			
		points_arr.push_back(curr_point)
	
	print("Hello world\n")	
	print("Points:")
	print(points_arr)
	
	print("Indices:")
	print(indices_arr)
	
func export_surface():
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = points_arr
	array[Mesh.ARRAY_INDEX] = indices_arr
	
	return {
		"primitive": Mesh.PRIMITIVE_TRIANGLES,
		"mesh_array": array,
		"points": points_arr,
		"indices": indices_arr,
	}
