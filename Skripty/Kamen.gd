extends Area2D

var rychlost = 950
onready var efekty = get_node("Efekty")
onready var timer = get_node("Timer")
onready var textura = get_node("Textura")
var cilova_pozice = Vector2.ZERO
var velocity
var speed = 200

func trefen_srazen():
	efekty.emitting = true
	timer.start()
	textura.visible = false

func _on_Kamen_area_entered(area):
	trefen_srazen()

func _on_Timer_timeout():
	queue_free()

func _on_Kamen_body_entered(body):
	trefen_srazen()

func _physics_process(delta):
	global_position.x = delta * velocity.x * speed
	global_position.y = delta * velocity.y * speed

func _ready():
	velocity = global_position.direction_to(cilova_pozice)
	
