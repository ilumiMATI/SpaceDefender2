extends Area2D

func _ready():
	connect("body_entered", destroy)
	connect("area_entered", destroy)

func destroy(body):
	if body.get_parent() is Laser:
		print_debug("Removing Laser object")
	else:
		print_debug("Removing unknown object")
	body.get_parent().queue_free()
