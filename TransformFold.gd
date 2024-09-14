extends Node
class_name TransformFold

func fold(
	fl_start: Vector3, fl_end: Vector3, 
	points_to_transform_i, ## Array[[plane index, point index]]
	planes: Array[TriangularPlane]
) -> Array[TriangularPlane]:
	print("hello")
	
	var res: Array[TriangularPlane] = []
	var vertices_arr: Array[PackedVector3Array] = []
	
	for plane in planes:
		vertices_arr.append(plane.export_surface()["points"])
	
	var angle = PI
	var axis: Vector3 = (fl_end - fl_start).normalized()
	
	for index in points_to_transform_i:
		#print("(plane " + index[0] + ", point " + index[1] + "): \n")
		#print(res[index[0]][index[1]] + " -> ")
		
		var new_point = vertices_arr[index[0]][index[1]].rotated(axis, angle)
		vertices_arr[index[0]].set(index[1], new_point)
		
		#print(res[index[0]][index[1]])
		
	for vertices in vertices_arr:
		res.append(TriangularPlane.new(vertices))
	
	return res
	
	
	
	
