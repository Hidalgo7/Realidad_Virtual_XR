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
	if button_name == "trigger_click":
		# Solo spawneamos si la mano está vacía
		if pickup_function and not is_instance_valid(pickup_function.picked_up_object):
			spawn_and_hold_box()
	if button_name == "grip_click":
		var pickable = _find_pickable()
	
		if pickup_function and pickable:
			# call_deferred es CRÍTICO para que la física registre el objeto antes de agarrarlo
			pickup_function.call_deferred("_pick_up_object", pickable)
			_spawned_box_active = true

func _on_button_released(button_name: String):
	if (button_name == "trigger_click" or button_name == "grip_click") and _spawned_box_active:
		drop_box()

func spawn_and_hold_box():
	if not box_scene: return

	var box_instance = box_scene.instantiate()
	get_tree().current_scene.add_child(box_instance)
	
	# Colocamos la caja en la posición del controlador
	box_instance.global_transform = global_transform

	# Buscamos el nodo que sea Pickable
	var pickable = _find_new_pickable(box_instance)
	
	if pickup_function and pickable:
		# call_deferred es CRÍTICO para que la física registre el objeto antes de agarrarlo
		pickup_function.call_deferred("_pick_up_object", pickable)
		_spawned_box_active = true
		

func drop_box():
	if pickup_function and is_instance_valid(pickup_function.picked_up_object):
		pickup_function.drop_object()
	
	_spawned_box_active = false

# Función auxiliar para encontrar el RigidBody Pickable
func _find_new_pickable(node: Node) -> Node3D:
	if node is RigidBody3D: # Si la raíz ya es el RigidBody
		return node
	for child in node.get_children():
		if child is RigidBody3D:
			return child
	return null

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
