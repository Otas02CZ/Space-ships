extends KinematicBody2D

export (float) var rotation_speed = 1.5
export var inc_zrychleni = 1
export var inc_zpomaleni = 0.1
export var inc_brzdeni = 2
export var max_speed = 195
var max_zrychleni = 100
var speed = 0
var rotacni_deleni = 100
var velocity = Vector2()
var rotation_dir
onready var pozice = get_node("Vystrely")
onready var scn_strela = preload("res://Sceny/Projectile.tscn")

func _ready():
	return 

func vystrel():
	var strela = scn_strela.instance()
	$"/root/Hra/Projektily".add_child(strela)
	strela.transform = pozice.global_transform

func get_input():
	rotation_dir = 0
	var zmena = false
	var brzda = false
	velocity = Vector2.ZERO
	if Input.is_action_pressed("to_right"):
		rotation_dir += 1
	if Input.is_action_pressed("to_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("back"):
		speed -= inc_zrychleni
		zmena = true
	if Input.is_action_pressed("front"):
		if speed<max_speed:
			speed += inc_zrychleni
		zmena = true
	if Input.is_action_pressed("brzda"):
		brzda = true
	if !zmena:
		if speed>0:
			speed -= inc_zpomaleni
		elif speed<0:
			speed += inc_zpomaleni
	if brzda:
		if abs(speed)>=1:
			if speed>0:
				speed -= inc_brzdeni
			elif speed<0:
				speed += inc_brzdeni
		else:
			speed = 0
	if Input.is_action_pressed("strileni"):
		vystrel()
	velocity = Vector2( speed, 0).rotated(rotation)


func _process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta * speed/rotacni_deleni
	velocity = move_and_slide(velocity)
	print(velocity)
