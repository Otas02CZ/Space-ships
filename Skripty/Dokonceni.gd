extends Node2D

onready var textSkore = get_node("HodnotaSkore")

func _ready():
	textSkore.text = str(Skore.skore)
	print(Skore.skore)

func _on_play_pressed():
	get_tree().change_scene("res://Sceny/Hra.tscn")


func _on_exit_pressed():
	get_tree().quit()
