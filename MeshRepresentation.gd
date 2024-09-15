extends Node

const TriangularPlane := preload("res://TriangularPlane.gd")
const TransformFold := preload("res://TransformFold.gd")

@export var mesh_path : NodePath

var debug_tp_old = []
var debug_tp_new = []
# Points defined as list of Vector2
var points = [
	Vector3(-10, 0, 10), 
	Vector3(10,0,10), 
	Vector3(10, 0, 0), 
	Vector3(10, 0, -10), 
	Vector3(0, 0, -10), 
	Vector3(-10, 0, -10)
]
var planes = [[0, 1, 2, 3, 4, 5]]

#var points = [
	#Vector3(-10, 10, 0),
	#Vector3(10, 10, 0),
	#Vector3(10, -10, 0),
	#Vector3(-10, -10, 0)
	#]
#var planes = [[0, 1, 2, 3]]

# Line defined as indices
var start_point = 2
var end_point = 4
var transform_fold : TransformFold;

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
	transform_fold = TransformFold.new()
	#start_point = 1
	#end_point = 3
	fold()
	print(points)
	print(planes)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_N:
			print("N was pressed")
			#get_node(mesh_path).recreate_plane_scene(debug_tp_new)
		if event.keycode == KEY_M:
			print("M was pressed")
			#get_node(mesh_path).recreate_plane_scene(debug_tp_old)
# Called when user clicks a point in space & collides.
func on_point_click(pt):
	var closest_pt = get_closest_point(pt)
	if (mode == Mode.SELECTING_POINT_1): start_point = closest_pt
	else: end_point = closest_pt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func append_arr(arr1, arr2):
	if (arr2 != null):
		arr1.append_array(arr2)

func get_points_from_fold(start_pt, end_pt, pts, is_inside, include_line):
	print(start_pt)
	if (is_inside): 
		var arr = []
		append_arr(arr, range(start_pt + 1, end_pt))
		print(arr)
		if include_line:
			arr.insert(0, start_pt)
			arr.append(end_pt)
		print(arr)
		return arr
	else: 
		var arr = []
		append_arr(arr, range(0, start_pt))
		print(arr)
		if include_line:
			arr.append(start_pt)
			print(arr)
			arr.append(end_pt)
			print(arr)
		append_arr(arr, range(end_pt + 1, len(pts)))
		print(arr)
		return arr
		

func get_changed_points_from_fold(start_pt, end_pt, pts):
	var new_pts
	var l1 = start_pt - end_pt - 1
	var l2 = len(pts) - l1 - 2
	return get_points_from_fold(start_pt, end_pt, pts, l1 <= l2, false)
		
func fold():
	var skip = false
	for i in range(0, len(planes)):
		if skip: 
			skip = false
			continue
		var plane_start_pt = planes[i].find(start_point)
		var plane_end_pt = planes[i].find(end_point)
		if (plane_start_pt != -1 and plane_end_pt != -1):
			var inside_pts = get_points_from_fold(plane_start_pt, plane_end_pt, planes[i], INSIDE_FOLD, true)
			var outside_pts = get_points_from_fold(plane_start_pt, plane_end_pt, planes[i], OUTSIDE_FOLD, true)
			var inside_plane = []
			var outside_plane = []
			for j in inside_pts: 
				inside_plane.append(planes[i][j])
			for k in outside_pts:
				outside_plane.append(planes[i][k])
			planes[i] = inside_plane
			planes.insert(i + 1, outside_plane)
			skip = true
	
	var triangular_planes : Array[TriangularPlane] = []
	var indices_to_modify = get_changed_points_from_fold(start_point, end_point, points)
	var final_indices = []
	
	# Generate Final Indices
	for p in range(0, len(planes)):
		for i in indices_to_modify:
			if planes[p].has(i):
				final_indices.append([p, planes[p].find(i)])
	
	# Generate Triangular Planes
	for plane in planes:
		var triangular_plane_points = []
		for p in plane:
			triangular_plane_points.append(points[p])
		triangular_planes.append(TriangularPlane.new(PackedVector3Array(triangular_plane_points)))
	
	
	debug_tp_old = triangular_planes
	
	#var new_triangular_planes = triangular_planes
	print("Current rendered plane indices")
	print(planes)
	var new_triangular_planes = transform_fold.fold(points[start_point], points[end_point], PI/4, final_indices, triangular_planes.duplicate())
	get_node(mesh_path).recreate_plane_scene(new_triangular_planes)
	# todo, update the points in my representation
	# debug
	
	debug_tp_new.append_array(new_triangular_planes)

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
	var closest_dist = INF
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
