extends Node

# Points defined as list of Vector2
var points = []
var planes = []
# Line defined as indices
var start_point = 0
var end_point = 0

enum Mode {
	SELECTING_POINT_1,
	SELECTING_POINT_2,
	SELECTING_ANGLE,
}

var mode : Mode

const INSIDE_FOLD = true;
const OUTSIDE_FOLD = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called when user clicks a point in space & collides.
func on_point_click(pt):
	var closest_pt = get_closest_point(pt)
	if (mode == Mode.SELECTING_POINT_1): start_point = closest_pt
	else: end_point = closest_pt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_points_from_fold(start_pt, end_pt, pts, is_inside):
	if (is_inside): 
		return range(start_pt + 1, end_pt)
	else: 
		var arr = range(0, start_pt)
		arr.append_array(range(end_pt + 1, len(pts)))
		return arr
		
func get_changed_points_from_fold(start_pt, end_pt, pts):
	var new_pts
	var l1 = start_pt - end_pt - 1
	var l2 = len(pts) - l1 - 2
	return get_points_from_fold(start_pt, end_pt, pts, l1 <= l2)
		
func fold():
	var skip = false
	for i in range(0, len(planes)):
		if skip: 
			skip = false
			continue
		var plane_start_pt = planes[i].find(start_point)
		var plane_end_pt = planes[i].find(end_point)
		if (plane_start_pt != -1 and plane_end_pt != -1):
			var inside_pts = get_points_from_fold(plane_start_pt, plane_end_pt, planes[i], INSIDE_FOLD)
			var outside_pts = get_points_from_fold(plane_start_pt, plane_end_pt, planes[i], OUTSIDE_FOLD)
			var inside_plane = []
			var outside_plane = []
			for j in inside_pts: 
				inside_plane.append(planes[i][j])
			for k in outside_pts:
				outside_plane.append(planes[i][k])
			planes[i] = inside_plane
			planes.insert(i + 1, outside_plane)
			skip = true
	
	var triangular_planes = []
	var indices_to_modify = get_changed_points_from_fold(start_point, end_point, points)
	var final_indices = []
	
	for p in range(0, len(planes)):
		for i in indices_to_modify:
			if planes[p].has(i):
				final_indices.append([p, planes[p].find(i)])
	
	for plane in planes:
		var triangular_plane_points = []
		for p in plane:
			triangular_plane_points.append(points[p])
		triangular_planes.append(TriangularPlane(PackedVector3Array(triangular_plane_points)))
	
	rotate_points_about_line(start_point, end_point, final_indices, triangular_planes)
				
				
	
	
	
	
	
# Computes distance between a point A and line BC.
# https://math.stackexchange.com/questions/1905533/find-perpendicular-distance-from-point-to-line-in-3d
func compute_distance(A, B, C):
	var d = (C - B) / (C - B).length()
	var v = A - B
	var t = v.dot(d)
	var P = B + t * d
	return (P - A).length()

# Computes closest point to A that lies on line BC.
func compute_closest_point(A, B, C):
	var d = (C - B) / (C - B).length()
	var v = A - B
	var t = v.dot(d)
	var P = B + t * d
	return P

func get_closest_point(pt):
	var closest_dist = 10000000000000000000
	var closest_start = 0
	var closest_end = 0
	var temp_dist = 0
	var temp_start = 0
	var temp_end = 0
	for i in range(0, len(points)):
		# Compare each line
		temp_start = i
		temp_end = i + 1
		if temp_end >= len(points): temp_end = 0
		
		# Account for the case that closest point is already included in the list
		temp_dist = (points[i] - pt).length()
		if (temp_dist < closest_dist):
			closest_dist = temp_dist
			closest_start = 0
			closest_end = -1
			
		# Account for the case that we need to create a new point on a preexisting line
		temp_dist = compute_distance(pt, points[temp_start], points[temp_end])
		if (temp_dist < closest_dist):
			closest_dist = temp_dist
			closest_start = temp_start
			closest_end = temp_end
		
	if (closest_end == -1): # Case where we return pre existing point
		return closest_start
	else: # Case where we make new point on a line
		points.insert(closest_end, compute_closest_point(pt, closest_start, closest_end))
		return closest_end


# TO BE IMPLEMENTED!!!!!
# start pt - Vector3, end pt - Vector3, indexes - list of int * int tuple *cough* list, planes - list of list of Vector3
func rotate_points_about_line(start_pt, end_pt, indices, planes):
	return points;
		
			
			
		
	
