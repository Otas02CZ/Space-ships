extends Control

onready var textSkore = get_node("HodnotaSkore")
onready var video = get_node("Video")

func _ready():
	textSkore.text = str(Skore.skore)

func _on_play_pressed():
	Audio.nastav_soundtrack()
	get_tree().change_scene("res://Sceny/Hra.tscn")


func _on_exit_pressed():
	get_tree().quit()

func _physics_process(_delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()


func _on_Video_finished():
	video.play()
