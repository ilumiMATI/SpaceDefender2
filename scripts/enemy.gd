class_name Enemy
extends CharacterBody2D

var SPEED := 20
var randomness := 5

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED += randi_range(SPEED - randomness,SPEED + randomness)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y = SPEED
	move_and_slide()
