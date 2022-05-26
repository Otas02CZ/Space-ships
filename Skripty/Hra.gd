extends Node2D

# PROMENNE
# - exportovane promenne
export var speed = 200
export var rotation_speed = 1.5
export var max_zivotu = 6
var smer = Array()
# - predpripravene promenne odkazujici na poduzly uzlu Hra
export (Vector2) var map_size = Vector2(1920, 1080)
var viewport = Vector2(1280, 720)
onready var hrac = get_node("Hrac")
onready var kamera = get_node("Hrac/Camera2D")
onready var ohraniceni = get_node("Ohraniceni/OhraniceniKolize")
onready var pozadi_1 = get_node("ScrollovaciPozadi/Vrstva_1/Textura_1")
onready var pozadi_2 = get_node("ScrollovaciPozadi/Vrstva_2/Textura_2")
onready var pozadi_3 = get_node("ScrollovaciPozadi/Vrstva_3/Textura_3")
onready var pozadi_4 = get_node("ScrollovaciPozadi/Vrstva_4/Textura_4")
onready var vrstva_1 = get_node("ScrollovaciPozadi/Vrstva_1")
onready var vrstva_2 = get_node("ScrollovaciPozadi/Vrstva_2")
onready var vrstva_3 = get_node("ScrollovaciPozadi/Vrstva_3")
onready var vrstva_4 = get_node("ScrollovaciPozadi/Vrstva_4")
onready var kameny = get_node("Kameny")
# - predpripravene promenne prednactenych kamenu
onready var kamen_1 = preload("res://Sceny/Kamen_1.tscn")
onready var kamen_2 = preload("res://Sceny/Kamen_2.tscn")
onready var kamen_3 = preload("res://Sceny/Kamen_3.tscn")
# - normalni promenne"
var zivoty

func nastav_hru():
	hrac.global_position = Vector2(map_size.x/2, map_size.y/2)
	hrac.speed = 0
	$Hrac.speed = 0
	pozadi_1.set_region_rect(Rect2(Vector2.ZERO, map_size))
	pozadi_2.set_region_rect(Rect2(Vector2.ZERO, map_size))
	pozadi_3.set_region_rect(Rect2(Vector2.ZERO, map_size))
	pozadi_4.set_region_rect(Rect2(Vector2.ZERO, map_size))
	vrstva_1.set_mirroring(map_size)
	vrstva_2.set_mirroring(map_size)
	vrstva_3.set_mirroring(map_size)
	vrstva_4.set_mirroring(map_size)
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
	hrac.speed = speed
	hrac.rotation_speed = rotation_speed

func _ready():
	hrac.global_position = Vector2.ZERO
	nastav_hru()
	zivoty = max_zivotu
	$CanvasLayer/ZivotyHodnota.text = str(zivoty)
	Skore.vynuluj_skore()

func vytvor_kamen():
	match randi() % 3:
		0 :
			return kamen_1.instance()
		1 :
			return kamen_2.instance()
		2 :
			return kamen_3.instance()

func vytvor_pozici_pro_kamen():
	while true:
		var x = randi() % int(map_size.x)
		var y = randi() % int(map_size.y)
		if abs(x-hrac.global_position.x)<viewport.x/2:
			continue
		if abs(y-hrac.global_position.y)<viewport.y/2:
			continue
		return Vector2(x, y)

func _on_NOVY_KAMEN_timeout():
	var kamen = vytvor_kamen()
	kamen.cilova_pozice = hrac.global_position
	kamen.global_position = vytvor_pozici_pro_kamen()
	kamen.limity = map_size
	kameny.add_child(kamen)


func _on_Hrac_hit_kamen():
	zivoty -= 1
	$CanvasLayer/ZivotyHodnota.text = str(zivoty)
	if (zivoty==0):
		Audio.nastav_intro()
		get_tree().change_scene("res://Sceny/Dokonceni.tscn")
