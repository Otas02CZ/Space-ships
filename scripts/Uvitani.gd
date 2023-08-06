extends Node2D

@onready var video = get_node("Video")

func _ready():
	Audio.hraj_hudbu()

func _on_Zapni_pressed():
	Audio.nastav_soundtrack()
	get_tree().change_scene_to_file("res://scenes/Hra.tscn")

func _physics_process(_delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()


func _on_Video_finished():
	video.play()
