extends Node
class_name TransformFold


func fold(
	fl_start: Vector3, fl_end: Vector3, 
	rotation_angle: float,
	points_to_transform_i, ## Array[[plane index, point index]]
	planes: Array[TriangularPlane]
) -> Array[TriangularPlane]:	
	var res: Array[TriangularPlane] = []
	var vertices_arr: Array[PackedVector3Array] = []
	
	for plane in planes:
		vertices_arr.append(plane.export_surface()["points"])
	
	var axis: Vector3 = (fl_end - fl_start).normalized()
	
	for index in points_to_transform_i:
		var old_point = vertices_arr[index[0]][index[1]]
		var closest_point = compute_closest_point(old_point, fl_start, fl_end)
		var point = old_point - closest_point
		
		var new_point = point.rotated(axis, rotation_angle) + closest_point
		vertices_arr[index[0]].set(index[1], new_point)
		
		var point_fmt = "Plane %d, Point %d: %v -> %v\n"
		print(point_fmt % [index[0], index[1], old_point, new_point])
		
	for vertices in vertices_arr:
		res.append(TriangularPlane.new(vertices))
	
	return res

func compute_closest_point(point, line_start, line_end):
	var d = (line_end - line_start) / (line_end - line_start).length()
	var v = point - line_start
	var t = v.dot(d)
	var P = line_start + t * d
	return P
