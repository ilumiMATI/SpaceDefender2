class_name Player
extends CharacterBody2D

@export var laser_scene: PackedScene = preload("res://scenes/laser.tscn")
@onready var shoot_marker = $ShootMarker


const SPEED = 80.0

func _physics_process(delta):

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = velocity.lerp(direction * SPEED, 10 * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, 10 * delta)

	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		print_debug("Laser shot")
		shoot()

func shoot():
	var laser = laser_scene.instantiate()
	laser.global_position = shoot_marker.global_position
	get_parent().add_child(laser)
	
