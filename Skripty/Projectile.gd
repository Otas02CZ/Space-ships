extends Area2D

var speed = 750
onready var timer = get_node("Timer")

func _ready():
	timer.start()

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Timer_timeout():
	queue_free()
	
func _on_Projectile_area_entered(_area):
	queue_free()
