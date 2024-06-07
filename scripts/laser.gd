extends Node2D

@export var SPEED: float = 200
var direction := Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Vector2.UP.rotated(rotation)
	position += direction * SPEED * delta

func _on_area_2d_body_entered(body):
	print("Laser Hit")
	body.get_parent().queue_free()
	queue_free()
