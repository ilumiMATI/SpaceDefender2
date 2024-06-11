extends Area2D

func _ready():
	connect("body_entered", destroy)
	connect("area_entered", destroy)

func destroy(body):
	if body is Laser:
		print_debug("Removing Laser object")
	elif body is Enemy:
		print_debug("Removing Enemy object")
	else:
		print_debug("Removing unknown object")
	body.queue_free()
