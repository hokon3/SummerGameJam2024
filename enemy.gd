class_name Enemy
extends Node2D

var images = [
	"res://Assets/EnemyImages/DALL·E 2024-08-18 19.53.06 - A cartoon-style scene of an evil-looking kid standing on a beach. The kid is holding a beach spade with a mischievous, sinister grin on their face. Th.webp",
	"res://Assets/EnemyImages/DALL·E 2024-08-18 19.50.23 - A medieval knight with redneck traits standing in a grassy plain. The knight is wearing traditional armor, but with a few unconventional elements like.webp",
	"res://Assets/EnemyImages/DALL·E 2024-08-18 19.53.48 - A detailed depiction of a biblical angel in a surreal and ethereal style. The angel has multiple eyes and wings, resembling traditional descriptions f.webp"
]

var current = 0

var sprite2D : Sprite2D

var health = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func loadNextEnemy() -> bool:
	current += 1
	if (current == images.size()):
		return false
	sprite2D = get_node("Sprite2D")
	sprite2D.texture = load(images[current])
	health = 10
	return true
	
func takeDamage(damage : int) -> bool:
	health -= damage
	if (health <= 0):
		return false
	return true
