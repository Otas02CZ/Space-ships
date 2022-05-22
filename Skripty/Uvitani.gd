extends Node2D

func _ready():
	Audio.hraj_hudbu()

func _on_Zapni_pressed():
	get_tree().change_scene("res://Sceny/Hra.tscn")
