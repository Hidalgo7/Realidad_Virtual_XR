extends Node3D

@export var width := 1.0
@export var depth := 1.0
@export var dash := 0.2
@export var gap := 0.1
@export var height := 0.01

func generate_borders(new_width: float, new_depth: float ):
	width = new_width
	depth = new_depth
	
	for child in get_children():
		child.queue_free()
	
	create_side(Vector3(-width/2,0,-depth/2), Vector3(width,0,0))
	create_side(Vector3(-width/2,0, depth/2), Vector3(width,0,0))
	create_side(Vector3(-width/2,0,-depth/2), Vector3(0,0,depth))
	create_side(Vector3( width/2,0,-depth/2), Vector3(0,0,depth))

func create_side(start, dir):
	var length = dir.length()
	var step = dash + gap
	var count = int(length / step)
	var norm = dir.normalized()

	var is_along_x = abs(norm.x) > abs(norm.z)
	for i in count:
		var m = MeshInstance3D.new()
		m.mesh = BoxMesh.new()
		if is_along_x:
			m.scale = Vector3(dash, height, 0.08)
		else:
			m.scale = Vector3(0.08, height, dash)
		var pos = start + norm * (i * step + dash * 0.5)
		m.position = pos
		add_child(m)
