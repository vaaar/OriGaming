extends Camera3D

var mouse_sens = 0.3
var camera_anglev = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_origin_view()
	pass


func set_origin_view(point_to_face = Vector3(0,0,0)):
	look_at(point_to_face)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
