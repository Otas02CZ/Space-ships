extends KinematicBody2D

export (float) var rotation_speed = 1.5
export var inc_zrychleni = 1
export var inc_zpomaleni = 0.1
export var max_speed = 195
var max_zrychleni = 100
var speed = 0

var velocity = Vector2()
var rotation_dir = 0
var smer = 0

func _ready():
	pass

func get_input():
	rotation_dir = 0
	var zmena = false
	velocity = Vector2.ZERO
	if Input.is_action_pressed("to_right"):
		rotation_dir += 1
	if Input.is_action_pressed("to_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("back"):
		#if speed<max_speed:
		speed -= inc_zrychleni
		zmena = true
	if Input.is_action_pressed("front"):
		if speed<max_speed:
			speed += inc_zrychleni
		zmena = true
	if !zmena:
		if speed>0:
			speed -= inc_zpomaleni
		if speed<0:
			speed += inc_zpomaleni
	velocity = Vector2( speed, 0).rotated(rotation)
		
	
func _process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta * speed 
	
	velocity = move_and_slide(velocity)
	print(velocity)
