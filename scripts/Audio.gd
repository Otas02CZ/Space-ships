extends Node

@onready var strileni = get_node("Strileni")
@onready var vybuch = get_node("Vybuch")
@onready var hudba = get_node("Hudba")

var soundtrack = preload("res://audio/soundtrack.ogg")
var intro = preload("res://audio/intro.ogg")
var pristi_hudba = null
var zmena_hudby = false

func hraj_strilej():
	if not strileni.playing:
		strileni.play()

func hraj_vybuch():
	vybuch.play()

func hraj_hudbu():
	hudba.play()

func nastav_soundtrack():
	zmena_hudby = true
	pristi_hudba = "soundtrack"

func nastav_intro():
	zmena_hudby = true
	pristi_hudba = "intro"

func _physics_process(delta):
	if zmena_hudby:
		if hudba.volume_db>-60:
			hudba.volume_db -= 20*delta
		else:
			zmen_hudbu()
			zmena_hudby = false

func zmen_hudbu():
	hudba.stop()
	match pristi_hudba:
		"soundtrack":
			hudba.volume_db = -6
			hudba.set_stream(soundtrack)
		"intro":
			hudba.volume_db = -16
			hudba.set_stream(intro)
	hudba.play()


func _on_Hudba_finished():
	if zmena_hudby:
		zmena_hudby = false
		zmen_hudbu()
