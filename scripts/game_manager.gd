extends Node

@onready var button_ar_16x9 = %AR16x9
@onready var button_ar_19_5x9 = %AR19_5x9
@onready var button_ar_20x9 = %AR20x9
@onready var button_low_res = %LowRes
@onready var camera = %Camera2D

@export var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
@onready var left_spawn_margin: Marker2D = $"../SpawnPositions/LeftMargin"
@onready var right_spawn_margin: Marker2D = $"../SpawnPositions/RightMargin"
@onready var spawn_time = $SpawnTime
@onready var enemies = $"../Enemies"

var spawn_threshold
var spawn_start

func _ready():
	# Signal connecting
	button_ar_16x9.connect("pressed", on_button_ar_16x9_pressed)
	button_ar_19_5x9.connect("pressed", on_button_ar_19_5x9_pressed)
	button_ar_20x9.connect("pressed", on_button_ar_20x9_pressed)
	button_low_res.connect("pressed", on_button_low_res_pressed)
	spawn_time.connect("timeout", spawn_enemies)
	
	# Spawn helper variables
	spawn_threshold = right_spawn_margin.position.x - left_spawn_margin.position.x
	spawn_start = left_spawn_margin.position.x

func spawn_enemies():
	var random_pos = randf_range(spawn_start, spawn_start + spawn_threshold)
	var enemy = enemy_scene.instantiate()
	enemy.global_position = Vector2(random_pos,left_spawn_margin.position.y)
	enemies.add_child(enemy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_button_low_res_pressed():
	print(str(720*0.8) + ":" + str(1280*0.8))
	get_window().size = Vector2(720*0.8,1280*0.8)

func on_button_ar_16x9_pressed():
	print("16:9")
	get_window().size = Vector2(720,1280)

func on_button_ar_19_5x9_pressed():
	print("19.5:9")
	get_window().size = Vector2(591,1280)

func on_button_ar_20x9_pressed():
	print("20:9")
	get_window().size = Vector2(576,1280)
