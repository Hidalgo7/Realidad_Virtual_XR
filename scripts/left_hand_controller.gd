extends XRController3D

@export var box_scene: PackedScene
@onready var pickup_function: Node3D = $FunctionPickup
@onready var grab_point = $GrabDetectPoint

# Variable para saber que la caja que tenemos fue la que spawneamos
var _spawned_box_active: bool = false

func _ready():
	button_pressed.connect(_on_button_pressed)
	button_released.connect(_on_button_released)

func _on_button_pressed(button_name: String):
	if button_name == "grip_click":
		var pickable = _find_pickable()
	
		if pickup_function and pickable:
			# call_deferred es CRÍTICO para que la física registre el objeto antes de agarrarlo
			pickup_function.call_deferred("_pick_up_object", pickable)
			_spawned_box_active = true

func _on_button_released(button_name: String):
	if button_name == "grip_click" and _spawned_box_active:
		drop_box()

func drop_box():
	if pickup_function and is_instance_valid(pickup_function.picked_up_object):
		pickup_function.drop_object()
	
	_spawned_box_active = false

func _find_pickable():
	
	var nearest_pickable = null
	var nearest_distance = INF
	for node in get_tree().current_scene.get_children():
		if not node is XRToolsPickable:
			continue
		
		var dist = grab_point.global_position.distance_to(node.global_position)
		
		# rango máximo de agarre
		if dist < 0.25 and dist < nearest_distance:
			nearest_distance = dist
			nearest_pickable = node
	
	return nearest_pickable
