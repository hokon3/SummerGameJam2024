class_name Player
extends Node2D

var images = [
	"res://Assets/PlayerImages/FishAndLegs.webp",
	"res://Assets/PlayerImages/JellyFish.webp",
	"res://Assets/PlayerImages/OctoEyes.webp"
]

var attacks = [
	[
		"Kick",
		"Bubbles",
		"Splash"
	],
	[
		"Whip",
		"Shock",
		"Wiggle"
	],
	[
		"Hug",
		"Stare",
		"Blink"
	]
]

var sprite2D : Sprite2D

var current = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func loadNextPlayer() -> void:
	current += 1
	if (current == images.size()):
		current = 0
	sprite2D = get_node("Sprite2D")
	sprite2D.texture = load(images[current])
