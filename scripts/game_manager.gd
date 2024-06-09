extends Node


@onready var button_ar_16x9 = %AR16x9
@onready var button_ar_19_5x9 = %AR19_5x9
@onready var button_ar_20x9 = %AR20x9
@onready var button_low_res = %LowRes
@onready var camera = %Camera2D


func _ready():
	# Signal connecting
	button_ar_16x9.connect("pressed", on_button_ar_16x9_pressed)
	button_ar_19_5x9.connect("pressed", on_button_ar_19_5x9_pressed)
	button_ar_20x9.connect("pressed", on_button_ar_20x9_pressed)
	button_low_res.connect("pressed", on_button_low_res_pressed)

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
