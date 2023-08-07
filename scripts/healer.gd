extends Area2D

@onready var kolize = get_node("Collision")





func _on_area_entered(area):
	queue_free()
