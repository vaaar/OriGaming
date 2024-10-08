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
	var vertices := PackedVector3Array(
		[
			Vector3(-1,0,-1),
			Vector3(1,0,-1),
			Vector3(1,0,1),
			
			Vector3(-1,0,1),
			
			Vector3(0,0,1),
			Vector3(1,0,0)
		]
	)
	var indices := PackedInt32Array(
		[
			0,1,2,
			
			#0,2,3
			
			
		]
	)
	
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vertices
	array[Mesh.ARRAY_INDEX] = indices
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	mesh = array_mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
