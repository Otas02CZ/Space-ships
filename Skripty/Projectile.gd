extends Area2D

var speed = 750
onready var timer = get_node("Timer")

func _ready():
	timer.start()

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


func _on_Timer_timeout():
	queue_free()
