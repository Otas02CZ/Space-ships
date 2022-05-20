extends Node2D

onready var map_size = Vector2(1920, 1080)
onready var hrac = get_node("Hrac")
onready var kamera = get_node("Hrac/Camera2D")
onready var ohraniceni = get_node("Ohraniceni/OhraniceniKolize")
onready var pozadi = get_node("Pozadi")
var kameny


func _ready():
	hrac.global_position = Vector2(map_size.x/2, map_size.y/2)
	pozadi.set_region_rect(Rect2(Vector2.ZERO, map_size))
	var polygon = PoolVector2Array()
	polygon.append(Vector2.ZERO)
	polygon.append(Vector2(0, map_size.y))
	polygon.append(map_size)
	polygon.append(Vector2(map_size.x, 0))
	ohraniceni.set_polygon(polygon)
	kamera.set_limit(MARGIN_LEFT, 0)
	kamera.set_limit(MARGIN_TOP, 0)
	kamera.set_limit(MARGIN_BOTTOM, map_size.y)
	kamera.set_limit(MARGIN_RIGHT, map_size.x)
