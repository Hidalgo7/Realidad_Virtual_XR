extends MeshInstance3D

var material

func _ready():
	material = get_active_material(0)

func _process(delta):
	material.emission_energy_multiplier = 2.0 + sin(Time.get_ticks_msec() / 200.0)
