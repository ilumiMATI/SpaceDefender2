class_name Player
extends CharacterBody2D

@export var laser_scene: PackedScene = preload("res://scenes/laser.tscn")
@onready var shoot_marker = $ShootMarker

@onready var view_to_world = get_viewport().get_canvas_transform().affine_inverse()
var distance_to_finger: Vector2
var finger_pressed_position: Vector2
var finger_position: Vector2
var finger_offset: Vector2
var finger_direct_offset: Vector2 = Vector2(0,-35)
var allow_movement: bool = false
var first_finger = null
var using_direct_touch = false
var finger_offset_scale: float = 1.5

@onready var direct_touch = %DirectTouch
@onready var offset_touch = %OffsetTouch
@onready var offset_scale = %OffsetScale

const SPEED = 95

func _ready():
	direct_touch.connect("pressed", set_direct_touch)
	offset_touch.connect("pressed", set_offset_touch)
	offset_scale.connect("value_changed", update_offset_scale)

func set_direct_touch():
	using_direct_touch = true
func set_offset_touch():
	using_direct_touch = false
func update_offset_scale(value):
	finger_offset_scale = value

func _physics_process(delta):
	match OS.get_name():
		"Windows", "macOS":
			var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			if direction:
				velocity = velocity.lerp(direction * SPEED, 10 * delta)
			else:
				velocity = velocity.lerp(Vector2.ZERO, 10 * delta)
		"Android":
			#if allow_movement: # Older movement
				#if using_direct_touch:
					#position = position.move_toward(finger_position + finger_direct_offset, SPEED * delta)
				#else:
					#position = position.move_toward(finger_pressed_position + finger_offset_scale * distance_to_finger + finger_offset, SPEED * delta)
			#else:
				#velocity = Vector2.ZERO
			if allow_movement:
				var direction: Vector2 = Vector2.ZERO
				if using_direct_touch:
					direction = finger_position + finger_direct_offset - position
				else:
					direction = finger_pressed_position + finger_offset_scale * distance_to_finger + finger_offset - position
				if direction.length() > 1:
					direction = direction.normalized()
					velocity = velocity.lerp(direction * SPEED, 10 * delta)
				else:
					velocity = velocity.lerp(Vector2.ZERO, 50 * delta)
				
			else:
				velocity = velocity.lerp(Vector2.ZERO, 50 * delta)
	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		print_debug("Laser shot")
		shoot()

func _input(event): # TODO: This needs a review
	if event is InputEventScreenTouch:
		if event.index == 1 and event.pressed:
			shoot()
		if event.index == 0 and event.pressed:
			first_finger = event
			finger_position = view_to_world * event.position
			if not using_direct_touch:
				finger_pressed_position = view_to_world * event.position
				distance_to_finger = view_to_world * event.position - finger_pressed_position
				finger_offset = position - finger_pressed_position
			else:
				distance_to_finger = view_to_world * event.position - position
			allow_movement = true
		if !event.pressed and first_finger != null and event.index == first_finger.index:
			first_finger = null
			allow_movement = false
		print(event)
	elif event is InputEventScreenDrag and first_finger != null:
		if event.index == first_finger.index:
			finger_position = view_to_world * event.position
			if using_direct_touch:
				distance_to_finger = view_to_world * event.position - position
			else:
				distance_to_finger = view_to_world * event.position - finger_pressed_position
			#if distance_to_finger.length() <= 5:
				#allow_movement = false
			#else:
				#allow_movement = true

func shoot():
	var laser = laser_scene.instantiate()
	laser.global_position = shoot_marker.global_position
	get_parent().add_child(laser)
	
