extends PathFollow3D

@export var speed := 1.0
@export var wheel_radius := 0.45

@export_group("Ruedas")
@export var wheel_fl : Node3D
@export var wheel_fr : Node3D
@export var wheel_rl : Node3D
@export var wheel_rr : Node3D

func _physics_process(delta: float) -> void:
	
	# mover camion
	progress += speed * delta
	
	# girar ruedas
	var angular = speed / wheel_radius
	
	if wheel_fl: wheel_fl.rotate_x(angular * delta)
	if wheel_fr: wheel_fr.rotate_x(angular * delta)
	if wheel_rl: wheel_rl.rotate_x(angular * delta)
	if wheel_rr: wheel_rr.rotate_x(angular * delta)
