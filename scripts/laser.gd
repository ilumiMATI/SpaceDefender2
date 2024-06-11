class_name Laser
extends Node2D

@export var SPEED: float = 200
var direction := Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",_on_area_2d_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Vector2.UP.rotated(rotation)
	position += direction * SPEED * delta

func _on_area_2d_body_entered(body):
	print_debug("Laser Hit")
	body.queue_free()
	queue_free()
