extends Area3D

var max_boxes : int = 3
var current_boxes : int = 0

@onready var label: Label3D = get_parent().get_node("Label3D")

@export var points := 100

func _ready() -> void:
	max_boxes = randi_range(1, 5)
	_update_label()
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if current_boxes >= max_boxes:
		return
	
	if body.is_in_group("cajas"):
		current_boxes += 1
		_update_label()
		
		if GameManager:
			GameManager.add_score(points)
		
		body.queue_free()
		
		if current_boxes >= max_boxes:
			_on_zone_completed()
			
func _update_label():
	if label:
		label.text = str(current_boxes) + "/" + str(max_boxes)
		if current_boxes >= max_boxes:
			label.modulate = Color.GREEN
			
func _on_zone_completed():
	print("¡Zona completada!")
	monitoring = false
