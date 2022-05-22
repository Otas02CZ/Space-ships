extends Node

onready var strileni = get_node("Strileni")
onready var vybuch = get_node("Vybuch")
onready var hudba = get_node("Hudba")

func hraj_strilej():
	if not strileni.playing:
		strileni.play()

func hraj_vybuch():
	vybuch.play()

func hraj_hudbu():
	hudba.play()
