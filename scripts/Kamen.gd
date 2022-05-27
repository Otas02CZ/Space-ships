extends Area2D

onready var efekty = get_node("Efekty")
onready var zapni_efekty = get_node("ZapniEfekty")
onready var textura = get_node("Textura")
onready var kolize = get_node("Kolize")
var limity = Vector2.ZERO
var cilova_pozice = Vector2.ZERO
var smer
var speed
var rotace
var moving = true

func trefen_srazen():
	Audio.hraj_vybuch()
	moving = false
	efekty.emitting = true
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	zapni_efekty.start()
	textura.visible = false

func _on_Kamen_area_entered(area):
	trefen_srazen()
	if area.get_collision_layer()!=1:
		Skore.zvys_skore()

func _on_Timer_timeout():
	queue_free()

func _physics_process(delta):
	if moving:
		textura.rotate(rotace*delta)
		kolize.rotate(rotace*delta)
		move_local_x(smer.x * delta * speed)
		move_local_y(smer.y * delta * speed)
		if global_position.x<0 or global_position.x>limity.x or global_position.y<0 or global_position.y>limity.y:
			queue_free()

func _ready():
	speed = (randi()% 4 + 1) * 100
	rotace = PI/(randi()%10 + 4)
	smer = global_position.direction_to(cilova_pozice)
	
