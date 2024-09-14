extends Node


func fold(
	fl_start: Vector3, fl_end: Vector3, 
	points_to_transform_i, ## Array[[plane index, point index]]
	planes: Array[TriangularPlane]) -> Array[TriangularPlane]:
	var res: Array[TriangularPlane] = []
	var vertices_arr: Array[PackedVector3Array] = []
	
	for plane in planes:
		vertices_arr.append(plane.export_surface()["vertices"])
	
	var angle = PI
	var axis: Vector3 = (fl_end - fl_start).normalized()
	
	## index[0] = plane index
	## index[1] = point index
	for index in points_to_transform_i:
		var new_point = res[index[0]][index[1]].rotated(axis, angle)
		res[index[0]].set(index[1], new_point)
		
	for vertices in vertices_arr:
		res.append(TriangularPlane.new(vertices))
	
	return res
	
	
	
	
