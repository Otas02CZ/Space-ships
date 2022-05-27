extends Node

var skore = 0
var navyseni_skore = 100

func zvys_skore():
	skore += navyseni_skore
	$"/root/Hra/CanvasLayer/SkoreHodnota".text = str(skore)

func vynuluj_skore():
	skore = 0
