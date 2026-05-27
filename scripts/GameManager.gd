extends Node

var score := 0
@onready var score_label : Label3D

func _process(_delta):
	if not score_label:
		score_label = get_tree().root.find_child("HUDScoreLabel", true, false) as Label3D

func add_score(points):
	score += points
	print("Puntos:", score)
	if score_label:
		score_label.text = "Score: " + str(score)
