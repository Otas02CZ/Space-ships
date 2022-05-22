extends Area2D

var rychlost = 950
onready var efekty = get_node("Efekty")
onready var zapni_efekty = get_node("ZapniEfekty")
onready var textura = get_node("Textura")
var limity = Vector2.ZERO
var cilova_pozice = Vector2.ZERO
var velocity
var speed = 200
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
		move_local_x(velocity.x * delta * speed)
		move_local_y(velocity.y * delta * speed)
		if global_position.x<0 or global_position.x>limity.x or global_position.y<0 or global_position.y>limity.y:
			queue_free()

func _ready():
	velocity = global_position.direction_to(cilova_pozice)
	

