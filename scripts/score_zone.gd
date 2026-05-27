extends Node3D

@export_group("Dimensiones de la zona")
@export var zone_width = 1.0
@export var zone_depth = 1.0

@onready var area_collision: CollisionShape3D = $Area3D/CollisionShape3D
@onready var floor_mesh: MeshInstance3D = $MeshInstance3D
@onready var border_lines: Node3D = $BorderLines

func _ready() -> void:
	if area_collision and area_collision.shape:
		area_collision.shape = area_collision.shape.duplicate()
		area_collision.shape.size = Vector3(zone_width, area_collision.shape.size.y, zone_depth)
		
	if floor_mesh and floor_mesh.mesh:
		floor_mesh.mesh = floor_mesh.mesh.duplicate()
		floor_mesh.mesh.size = Vector2(zone_width, zone_depth)
		
	if border_lines:
		border_lines.generate_borders(zone_width, zone_depth) 
