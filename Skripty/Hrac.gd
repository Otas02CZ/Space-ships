extends KinematicBody2D

var speed = 200
var rotation_speed = 1.5
var velocity = Vector2()
var rotation_dir = 0
onready var pozice = get_node("Vystrely")
onready var scn_strela = preload("res://Sceny/Projectile.tscn")

signal hit_kamen

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("back"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("front"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("strileni"):
		vystrel()
		Audio.hraj_strilej()
	if Input.is_action_pressed("exit"):
		get_tree().quit()

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

func vystrel():
	var strela = scn_strela.instance()
	$"/root/Hra/Projektily".add_child(strela)
	strela.transform = pozice.global_transform


func _on_Oblast_area_entered(_area):
	emit_signal("hit_kamen")
