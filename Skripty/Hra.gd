extends Node2D

# PROMENNE
# - exportovane promenne
export (int) var speed = 200
export (float) var rotation_speed = 1.5
export (int) var max_zivotu = 6
# - predpripravene promenne odkazujici na poduzly uzlu Hra
export (Vector2) onready var map_size = Vector2(1920, 1080)
var viewport = Vector2(640, 380)
onready var hrac = get_node("Hrac")
onready var kamera = get_node("Hrac/Camera2D")
onready var ohraniceni = get_node("Ohraniceni/OhraniceniKolize")
onready var pozadi = get_node("Pozadi")
onready var fps = get_node("CanvasLayer/fps")
onready var kameny = get_node("Kameny")
# - predpripravene promenne prednactenych kamenu
onready var kamen_1 = preload("res://Sceny/Kamen_1.tscn")
onready var kamen_2 = preload("res://Sceny/Kamen_2.tscn")
onready var kamen_3 = preload("res://Sceny/Kamen_3.tscn")
# - normalni promenne"
var sestrelene_kameny = 0
var skore = 0
var navyseni_skore = 100
var herni_cas
var zivoty
var aktualizuj_fps = false

func nastav_hru():
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
	hrac.speed = speed
	hrac.rotation_speed = rotation_speed

func _ready():
	nastav_hru()
	zivoty = max_zivotu

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

func _process(delta):
	if aktualizuj_fps:
		fps.text = str(int(1/delta))
		aktualizuj_fps = false


func _on_FPS_AKTUALIZACE_timeout():
	aktualizuj_fps = true

func zvys_skore():
	skore += navyseni_skore

func _on_NOVY_KAMEN_timeout():
	var kamen = vytvor_kamen()
	kamen.cilova_pozice = hrac.global_position
	kamen.global_position = vytvor_pozici_pro_kamen()
	kamen.limity = map_size
	kameny.add_child(kamen)


func _on_Hrac_hit_kamen():
	zivoty -= 1
	if (zivoty==0):
		print("PROHRA")
